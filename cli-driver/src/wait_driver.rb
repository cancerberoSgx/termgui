require_relative "time_driver"

class WaitDriver < TimeDriver
  def initialize
    super
    @waitTimeout = 5
    @waitInterval = 0.3
  end

  # blocking. TODO: non blocking using set_timeout
  def wait_for(predicate: nil, block: nil, timeout: 5, interval: 0.1)
    # throw "todo"
    # running = true
    # error = false
    timeout_listener = set_timeout timeout, Proc.new {
      # running = false
        clear_interval interval_listener
        block.call true
        # error = true
    }
    interval_listener = set_interval interval, Proc.new {
      # p 'interval'
      if predicate.call
        # running = false
        clear_interval interval_listener
        clear_timeout timeout_listener
        block.call false
      end
    }
    return timeout_listener, interval_listener
    # while running do
    #   if predicate.call
    #     running=false
    #   end
    #   sleep interval
    # end

  end

  def wait_data_includes(includes: nil, timeout: 5, interval: 0.1)
    wait_for(predicate: Proc.new {
               data_str.include? includes
             }, timeout: timeout, interval: interval)
  end
end
