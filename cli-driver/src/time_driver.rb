# frozen_string_literal: true

require 'timeout'
require 'pty'
require_relative 'base_driver'

# spawn given command using pty. This gives access both to command's stdin and stdout.
# How this works is looping until the process ends, reading stdout and notifying on each iteration.
# a simple timer is supported so operations like set_timeout or wait_until are supported
# users can register for new stdout data (to assert against)
# users can simulate keypress events
# be notified when stdout matches something
# This is the base class that is extended for adding more high level APIs
class TimeDriver < BaseDriver
  def initialize
    super
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

  def set_interval(seconds = @interval, block = nil)
    # TODO: seconds not implemented - block will be called on each input interval
    listener = { seconds: seconds, block: block, time: @time, target: @time + seconds }
    @interval_listeners.push listener
    listener
  end

  def clear_interval(listener)
    @interval_listeners.delete listener
  end

  protected

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

  def after_user_input
    super
    @time = Time.now
    dispatch_set_timeout
    dispatch_set_interval
  end
end
