require_relative 'emitter'
require_relative 'log'
require_relative 'event'
require_relative 'input_time'
require_relative 'input_grab'
require 'io/console'
require 'io/wait'
require_relative 'key'

module TermGui
  # responsible of listening stdin and event loop
  class Input < Emitter
    include InputTime
    include InputGrab

    attr_reader :interval, :stdin, :stopped

    def initialize(stdin = $stdin, interval = 0.0000001)
      super
      @interval = interval
      @stdin = stdin
      @stopped = true
      install(:key)
    end

    def stop
      @stopped = true
    end

    # starts listening for user input. Implemented like an event loop reading from @input_stream each @interval
    def start
      return self unless @stopped

      @stdin.raw do |io|
        @io = io
        @stopped = false
        loop do
          tick
          break if @stopped
        end
      end
    end

    # Once it `start`s this method is called on the loop to read input. Calls update_status which update timers (timeout - interval).
    # Could be useful for applications with their own event loops or time long blocking tasks to notify input/timeouts
    def tick
      char = get_char_or_sequence
      if char
        key = char.inspect
        key = key[1..key.length - 2]
        key = char_to_name(key) || char
        emit_key char, key
      else
        sleep @interval
      end
      update_status
    end

    def emit_key(char, key = char)
      event = KeyEvent.new key, char
      emit 'key', event
    end

    def write(s)
      @stdin.write s
    end

    protected

    def get_char_or_sequence(io = @io)
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
end

Input = TermGui::Input
