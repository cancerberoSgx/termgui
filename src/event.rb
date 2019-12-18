# frozen_string_literal: true

require_relative 'input'

# Base event class
class Event
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

# Represents a keyboard event
class KeyEvent < Event
  attr_reader :key, :raw

  def initialize(key, raw)
    super('key')
    @key = key
    @raw = raw
  end
end

# responsible of observe/emit user input events (KeyEvent)
class EventManager
  def initialize(input = Input.new)
    @key_listeners = {}
    input.add_listener('key', proc { |e| handle_key e })
  end

  def add_key_listener(key, listener)
    @key_listeners[key] = @key_listeners[key] || []
    @key_listeners[key].push(listener)
  end

  def remove_key_listener(key, listener)
    @key_listeners[key] = @key_listeners[key] || []
    @key_listeners[key].delete(listener)
  end

  def handle_key(e)
    key = e.key
    @key_listeners[key] = @key_listeners[key] || []
    @key_listeners[key].each do |listener|
      listener.call(e)
    end
  end
end
