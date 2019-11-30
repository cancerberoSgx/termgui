class Node < EventEmitter
  attr :attributes, :children
  def initialize
    @attributes = Attributes.new
    @children = []
  end
  def appendChild(child)
    @children.push(child)
    self
  end
end

class Attributes
  @attrs = {}
  def names
    @attrs.keys
  end
  def setAttribute(name, value)
    @attrs[name] = value
    self
  end
  def getAttribute(name)
    @attrs[name]
  end
end

def EventEmitter
  @listeners = []
  def addListener(name, &block)
    @listeners[name] = @listeners[name] || []
    @listeners[name].push(block)
    self
  end
  def removeListener(name, &block)
    throw 'Not implemented'
    self
  end
end