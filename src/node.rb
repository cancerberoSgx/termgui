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

  # returns child so something like the following is possible:
  # `@text = appendChild(Textarea.new model.text)`

  def appendChild(child)
    @children.push(child)
    child
  end

  def queryByAttr(attr, value)
    throw "todo"
    self
  end

  def render(screen)
    renderSelf screen
    renderChildren screen
  end

  def renderSelf(screen)
    throw "Abstract method"
  end

  def renderChildren(screen)
    @children.each { |c| c.render screen }
  end

  def setAttributes(attrs)
    attrs.each_key { |key| setAttribute(key.to_s, attrs[key]) }
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
  def initialize(attrs = {})
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
  def initialize(x = 0, y = 0, width = 0, height = 0, ch = Pixel.EMPTY_CH)
    super "element"
    setAttributes({
      x: x, y: y, width: width, height: height, ch: ch,
    })
  end

  def renderSelf(screen)
    screen.rect(getAttribute("x"), getAttribute("y"), getAttribute("width"), getAttribute("height"), getAttribute("ch"))
  end
end

class Document < Node
  def createElement(name)
    Element.new name
  end
end
