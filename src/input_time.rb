require_relative 'util'

# Add Input support for set_timeout and set_interval based on input event loop.
# Assumes `@time = Time.now` is assigned on each iteration.
module InputTime
  def initialize(*_args)
    @time = Time.now
    @timeout_listeners = []
    @interval_listeners = []
    @wait_timeout = 5
    @wait_interval = 0.1
  end

  # register a timeout listener that will be called in given seconds (aprox).
  # Returns a listener object that can be used with clear_timeout to remove the listener
  def set_timeout(seconds = @interval, block = nil, &proc_block)
    the_block = block == nil ? proc_block : block
    throw 'No block provided' if the_block == nil
    listener = { seconds: seconds, block: the_block, target: @time + seconds }
    @timeout_listeners.push listener
    listener
  end

  # clears a previoulsy registered timeout listener. Use the same block (or what set_timeout returned)
  def clear_timeout(listener)
    @timeout_listeners.delete listener
  end

  # similar to HTML window.setInterval
  def set_interval(seconds = @interval, block = nil, &proc_block)
    seconds = seconds == nil ? @interval : seconds
    the_block = block == nil ? proc_block : block
    throw 'No block provided' if the_block == nil
    listener = { seconds: seconds || @interval, block: the_block, next: @time + seconds }
    @interval_listeners.push listener
    listener
  end

  # clears a previoulsy registered interval listener. Use the same block (or what set_interval returned)
  def clear_interval(listener)
    @interval_listeners.delete listener
  end

  def wait_for(predicate, timeout = @wait_timeout, interval = @wait_interval, &block)
    throw 'No block provided' unless block
    interval_listener = nil
    timeout_listener = set_timeout(timeout) do
      clear_interval interval_listener
      block.call true
    end
    interval_listener = set_interval(interval) do
      if predicate.call
        clear_interval interval_listener
        clear_timeout timeout_listener
        block.call false
      end
    end
    [timeout_listener, interval_listener]
  end

  def clear_wait_for(listeners)
    clear_interval listeners[1]
    clear_timeout listeners[0]
  end

  def stop
    super
    @timeout_listeners = []
    @interval_listeners = []
  end

  protected

  def update_status
    @time = Time.now
    dispatch_set_interval
    dispatch_set_timeout
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
      if listener[:next] < @time
        listener[:block].call
        listener[:next] = @time + listener[:seconds]
      end
    end
  end
end
