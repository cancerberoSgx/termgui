# frozen_string_literal: true

require_relative 'input'

class Event
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

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
    @keyListeners = {}
    input.add_listener('key', proc { |e| handleKey e })
  end

  def addKeyListener(key, listener)
    @keyListeners[key] = @keyListeners[key] || []
    @keyListeners[key].push(listener)
  end

  def removeKeyListener(key, listener)
    @keyListeners[key] = @keyListeners[key] || []
    @keyListeners[key].delete(listener)
  end

  def handleKey(e)
    key = e.key
    @keyListeners[key] = @keyListeners[key] || []
    @keyListeners[key].each do |listener|
      listener.call(e)
    end
  end
end
