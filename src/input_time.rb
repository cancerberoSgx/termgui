require_relative 'util'

# Add Input support for set_timeout and set_interval based on input event loop.
# Assumes `@time = Time.now` is assigned on each iteration.
module InputTime
  def initialize(*_args)
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

  def update_time
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
      listener[:block].call
    end
  end
end
