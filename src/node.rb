class EventEmitter # TODO use ./emitter
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

class Node < EventEmitter
  attr :attributes, :children, :textContent, :parent , :name#TODO: parentDocument
  def initialize(name='node')
    @name=name
    @attributes = Attributes.new
    @children = []
    @textContent=''
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

class Element < Node
  def queryByAttr(attr, value)
    throw 'todo'
    self
  end
end

class Document < Node
  def createElement(name)
    Node.new name
  end
end