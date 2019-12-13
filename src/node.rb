class EventEmitter # TODO use ./emitter
  @listeners = []

  def add_listener(name, &block)
    @listeners[name] = @listeners[name] || []
    @listeners[name].push(block)
    self
  end

  def remove_listener(name, &block)
    throw "Not implemented"
    self
  end
end

class Node < EventEmitter
  attr :attributes, :children, :text, :parent, :name

  def initialize(name = "node", children = [], text = '')
    @name = name
    @attributes = Attributes.new
    @children = children
    @text = text
  end

  # returns child so something like the following is possible:
  # `@text = append_child(Textarea.new model.text)`
  def append_child(child)
    @children.push(child)
    child
  end

  def query_by_attribute(attr, value)
    throw "todo"
    self
  end

  def render(screen)
    render_self screen
    render_children screen
  end

  def render_self(screen)
    throw "Abstract method"
  end

  def render_children(screen)
    @children.each { |c| c.render screen }
  end

  def attributes(attrs)
    attrs.each_key { |key| set_attribute(key.to_s, attrs[key]) }
    self
  end

  def set_attribute(name, value)
    @attributes.set_attribute(name, value)
    self
  end

  def get_attribute(name)
    @attributes.get_attribute(name)
  end
end

class Attributes
  def initialize(attrs = {})
    @attrs = attrs
  end

  def names
    @attrs.keys
  end

  def set_attribute(name, value)
    @attrs[name] = value
    self
  end

  def get_attribute(name)
    @attrs[name]
  end
end

class Element < Node
  def initialize(x = 0, y = 0, width = 0, height = 0, ch = Pixel.EMPTY_CH)
    super "element"
    attributes({
      x: x, y: y, width: width, height: height, ch: ch,
    })
  end

  def render_self(screen)
    screen.rect(get_attribute("x"), get_attribute("y"), get_attribute("width"), get_attribute("height"), get_attribute("ch"))
  end

  # build in widget implementations will *grow* to fit their parent. 
  # However, if implemented, a widget like a button can be smart enough to declare its size, 
  # independently of current layout (in the button's case, the preferred size could be 
  # computed from its text length plus maring/padding)
  def preferred_size
  end
end

class Document < Node
  def create_element(name)
    Element.new name
  end
end
