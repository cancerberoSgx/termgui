require_relative "emitter"
require_relative "event"

class Input < Emitter
  attr :interval, :stdin, :stopped

  def initialize(stdin = $stdin, interval = 0.01)
    @interval = interval
    @stdin = stdin
    @stopped = true
    on(:key) # enables the 'key' event
  end

  def stop
    @stopped = true
  end

  def start
    if !@stopped
      return self
    end
    @stdin.raw do |io|
      @stopped = false
      loop do
        char = get_char_or_sequence(io)
        if char
          key = char.inspect
          key = key[1..key.length - 2]
          event = KeyEvent.new key, char
          self.emit("key", event)
          break if @stopped
        else
          sleep @interval
        end
      end
    end
  end

  def write(s)
    @stdin.write s
  end

  def defaultExitKeys
    self.subscribe("key", Proc.new { |e|
      if e.key == "q"
        self.stop
      end
    })
  end

  # TODO: implement setTimeout
  # @timer=0
  # def timeout(block, sec)
  #   timer=@timer++
  #   throw 'not impl'
  # end
end

require "io/console"
require "io/wait"
require_relative "key"

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
