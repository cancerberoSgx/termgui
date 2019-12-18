# frozen_string_literal: true

require_relative 'emitter'
require_relative 'event'
require 'io/console'
require 'io/wait'
require_relative 'key'

# responsible of listening stdin and event loop
class Input < Emitter
  attr_reader :interval, :stdin, :stopped

  def initialize(stdin = $stdin, interval = 0.05)
    @interval = interval
    @stdin = stdin
    @stopped = true
    on(:key) # enables the 'key' event
    @time = Time.now
    @timeout_listeners = []
    @interval_listeners = []
  end

  # register a timeout listener that will be called in given seconds (aprox).
  # Returns a listener object that can be used with clear_timeout to remove the listener
  def set_timeout(seconds, block)
    listener = { seconds: seconds, block: block, time: @time, target: @time + seconds }
    @timeout_listeners.push listener
    listener
  end

  def clear_timeout(listener)
    @timeout_listeners.delete listener
  end

  def set_interval(seconds = @interval, block)
    # TODO: seconds not implemented - block will be called on each input interval
    listener = { seconds: seconds, block: block, time: @time, target: @time + seconds }
    @interval_listeners.push listener
    listener
  end

  def clear_interval(listener)
    @interval_listeners.delete listener
  end

  def stop
    @stopped = true
  end

  # starts listening for user input. Implemented like an event loop reading from @input_stream each @interval
  def start
    return self unless @stopped

    @stdin.raw do |io|
      @stopped = false
      loop do
        char = get_char_or_sequence(io)
        if char
          key = char.inspect
          key = key[1..key.length - 2]
          event = KeyEvent.new key, char
          emit('key', event)
        else
          sleep @interval
        end
        @time = Time.now
        dispatch_set_interval
        dispatch_set_timeout
        break if @stopped
      end
    end
  end

  def write(s)
    @stdin.write s
  end

  def install_exit_keys
    subscribe('key', proc do |e|
      stop if e.key == 'q'
    end)
  end

  protected

  def get_char_or_sequence(io)
    if io.ready?
      result = io.sysread(1)
      while (CSI.start_with?(result) ||
             (result.start_with?(CSI) &&
              !result.codepoints[-1].between?(64, 126))) &&
            (next_char = get_char_or_sequence(io))
        result << next_char
      end
      result
    end
  end

  def dispatch_set_timeout
    @timeout_listeners.each do |listener|
      if listener[:target] < @time
        listener[:block].call
        @timeout_listeners.delete listener
      end
    end
  end

  def dispatch_set_interval
    @interval_listeners.each do |listener|
      listener[:block].call
    end
  end
end
