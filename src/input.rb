require_relative 'emitter'

class Input < Emitter
  def initialize(stdin)
    @stdin = stdin
    # enables the 'key' event
    on(:key)
  end
  def start
    @stdin.raw do |io|
      # last_read = Time.now
      prompted  = false
      loop do
        char = get_char_or_sequence(io)
        if char
          # last_read = Time.now
          prompted  = false
          puts "You typed:  #{char.inspect}\r\n"
          break if char == ?q
        else
          # if !prompted && Time.now - last_read > 3
          #   puts "Please type a character.\r\n"
          #   prompted = true
          # end
          sleep 0.1
        end
      end
    end
  end
end

require "io/console"
require "io/wait"

CSI = "\e["

def get_char_or_sequence(io)
  if io.ready?
    result = io.sysread(1)
    while ( CSI.start_with?(result)                        ||
            ( result.start_with?(CSI)                      &&
              !result.codepoints[-1].between?(64, 126) ) ) &&
          (next_char = get_char_or_sequence(io))
      result << next_char
    end
    result
  end
end
