require_relative 'emitter'
require_relative 'event'
require_relative 'input_time'
require_relative 'input_grab'
require 'io/console'
require 'io/wait'
require_relative 'key'

# responsible of listening stdin and event loop
class Input < Emitter
  include InputTime
  include InputGrab

  attr_reader :interval, :stdin, :stopped

  def initialize(stdin = $stdin, interval = 0.05)
    super
    @interval = interval
    @stdin = stdin
    @stopped = true
    install(:key) # enables the 'key' event
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
          emit_key char, key
        else
          sleep @interval
        end
        update_status
        break if @stopped
      end
    end
  end

  def emit_key(char, key = char)
    event = KeyEvent.new key, char
    emit 'key', event
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

  # called on each iteration, can be overriden by extenders
  def update_status
    super
  end

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
end
