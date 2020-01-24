# adds Input related methods to screen
module ScreenInput
  attr_accessor :exit_keys

  # Analog to HTML DOM / Node.js setTimeout() using input event loop
  # @param {Number} seconds
  def set_timeout(seconds = @input.interval, listener = nil, &block)
    the_listener = listener == nil ? block : listener
    throw 'No listener provided' if the_listener == nil
    @input.set_timeout(seconds, the_listener)
  end

  def clear_timeout(listener)
    @input.clear_timeout(listener)
  end

  # Analog to HTML DOM / Node.js setInterval() using input event loop
  # @param {Number} seconds
  def set_interval(seconds = @input.interval, listener = nil, &block)
    the_listener = listener == nil ? block : listener
    throw 'No listener provided' if the_listener == nil
    @input.set_interval(seconds, the_listener)
  end

  def clear_interval(listener)
    @input.clear_interval(listener)
  end

  def install_exit_keys
    return if @exit_keys_listener

    @exit_keys_listener = @input.subscribe('key') do |e|
      destroy if @exit_keys.include?(e.key)
    end
  end

  def uninstall_exit_keys
    return unless @exit_keys_listener

    @input.off('key', @exit_keys_listener)
    @exit_keys_listener = nil
  end
end
