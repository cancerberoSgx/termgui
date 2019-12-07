class EventEmitter # TODO use ./emitter
  @listeners = []

  def addListener(name, &block)
    @listeners[name] = @listeners[name] || []
    @listeners[name].push(block)
    self
  end

  def removeListener(name, &block)
    throw "Not implemented"
    self
  end
end

class Node < EventEmitter
  attr :attributes, :children, :textContent, :parent, :name

  def initialize(name = "node")
    @name = name
    @attributes = Attributes.new
    @children = []
    @textContent = ""
  end

  def appendChild(child)
    @children.push(child)
    self
  end

  def queryByAttr(attr, value)
    throw "todo"
    self
  end

  def render(screen)
    throw 'Abstract method node:render'
  end

  def setAttributes(attrs)
    attrs.each_key {|key| setAttribute(key.to_s, attrs[key])}
    self
  end

  def setAttribute(name, value)
    @attributes.setAttribute(name, value)
    self
  end

  def getAttribute(name)
    @attributes.getAttribute(name)
  end
end

class Attributes
  def initialize(attrs={})
    @attrs = attrs
  end

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
end

class Rect < Element
  def initialize(x=0,y=0,width=0,height=0,ch=Pixel.EMPTY_CH)
    super 'rect'
    setAttributes({
      x: x, y: y, width: width, height: height, ch: ch
    })
  end
  def render(screen)
    screen.rect(getAttribute('x'), getAttribute('y'), getAttribute('width'), getAttribute('height'), getAttribute('ch'))
  end
end

class Document < Node
  def createElement(name)
    Element.new name
  end
end
