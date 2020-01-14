# def f1
#   p 'f1'
#   yield
# end

# def f2(block)
#   p 'f2'
#   block.call
# end

# def f3
#   p 'f3'
#   yield
# end

# f1 do
#   f2 proc {
#     f3 do
#       p 'end'
#     end
#   }
# end

class Timer
  def initialize
    @time = Time.now
    @running = false
    @interval_listeners = []
  end

  # def
  def start
    @running = true
    while @running

    end
  end
end

# implement promise signatures
class Promise
  def self.next_tick
  end

  def initialize(block)
    @then_listeners = []
    @catch_listeners = []
    @resolve_handler = proc { |value|
      # p 'constru', @then_listeners
      @then_listeners.each { |listener| listener.call value }
    }
    @reject_handler = proc { |value|
      @catch_listeners.each { |listener| listener.call value }
    }
    block.call @resolve_handler, @reject_handler
  end

  def then(block)
    @then_listeners.push block
  end

  def catch(block)
    @catch_listeners.push block
  end
end

def test1
  Promise.new(proc { |resolve, _reject|
    # x = rand
    # if x > 0.5
    resolve.call 3.14
    # else
    # reject(x)
    # end
  })
end
test1.then(proc { |value|
  p 'seba'
  p value
})
