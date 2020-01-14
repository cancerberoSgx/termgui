require_relative 'input'
require_relative 'key'

# Base event class. Independent of Element.
class Event
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

# Event related with a Node (`target`) and a native event (`original_event`).
class NodeEvent < Event
  attr_reader :target, :original_event

  def initialize(name, target, original_event)
    super name
    @target = target
    @original_event = original_event
  end
end

# Represents a keyboard event. Independent of Element.
class KeyEvent < Event
  attr_reader :key, :raw

  def initialize(key, raw)
    super 'key'
    @key = key
    @raw = raw
  end

  def to_s
    "KeyEvent#{{ name: @name, key: @key, raw: @raw }}"
  end
end

# responsible of observe/emit user input events (KeyEvent)
class EventManager
  def initialize(input = Input.new)
    @key_listeners = {}
    @any_key_listener = []
    input.add_listener('key') { |e| handle_key e }
  end

  def add_key_listener(key, listener = nil, &block)
    the_listener = listener == nil ? block : listener
    throw 'No listener provided' if the_listener == nil
    @key_listeners[key] = @key_listeners[key] || []
    @key_listeners[key].push the_listener
  end

  def remove_key_listener(key, listener)
    @key_listeners[key] = @key_listeners[key] || []
    @key_listeners[key].delete listener
  end

  def add_any_key_listener(listener = nil, &block)
    the_listener = listener == nil ? block : listener
    throw 'No listener provided' if the_listener == nil
    @any_key_listener.push the_listener
  end

  def remove_any_key_listener(listener)
    @any_key_listener.delete listener
  end

  def handle_key(e)
    key = e.key
    @key_listeners[key] = @key_listeners[key] || []
    @key_listeners[key].each do |listener|
      listener.call(e)
    end
    @any_key_listener.each do |listener|
      listener.call(e)
    end
  end
end
