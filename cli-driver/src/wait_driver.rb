require_relative "time_driver"

class WaitDriver < TimeDriver
  def initialize
    super
    @wait_timeout = 5
    # @waitInterval = 0.3
  end

  # calls `block` when given `predicate` returns true. (Non blocking operation)
  # If given `timeout` is reach it calls block with true, otherwise with false. 
  # TODO: interval not supported
  def wait_for(predicate: nil, block: nil, timeout: @wait_timeout, interval: 0.1)
    timeout_listener = set_timeout timeout, Proc.new {
        clear_interval interval_listener
        block.call true
    }
    interval_listener = set_interval interval, Proc.new {
      if predicate.call
        clear_interval interval_listener
        clear_timeout timeout_listener
        block.call false
      end
    }
    return timeout_listener, interval_listener
  end

  def wait_timeout=(timeout)
    @wait_timeout = timeout
  end
  
  def wait_data_includes(includes: nil, timeout: 5, interval: 0.1)
    wait_for(predicate: Proc.new {
        data_str.include? includes
      }, 
      timeout: timeout, 
      interval: interval
    )
  end
end
