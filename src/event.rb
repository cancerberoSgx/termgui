require_relative "input"

class Event
  attr :name

  def initialize(name)
    @name = name
  end
end

class KeyEvent < Event
  attr :key, :raw

  def initialize(key, raw)
    super("key")
    @key = key
    @raw = raw
  end
end

class EventManager
  # attr_accessor :keyListeners
  def initialize(input = Input.new)
    @keyListeners = {}
    input.addListener("key", Proc.new { |e| handleKey e })
  end

  def addKeyListener(key, listener)
    @keyListeners[key] = @keyListeners[key] || []
    @keyListeners[key].push(listener)
  end

  def removeKeyListener(key, listener)
    @keyListeners[key] = @keyListeners[key] || []
    @keyListeners[key].delete(listener)
  end

  # protected
  def handleKey(e)
    key = e.key
    @keyListeners[key] = @keyListeners[key] || []
    @keyListeners[key].each { |listener|
      listener.call(e)
    }
  end
end
