require_relative 'node'

class Element < Node
  def initialize(x: 0, y: 0, width: 0, height: 0, ch: Pixel.EMPTY_CH, children: [], text: "", name: "element", attributes: {})
    super name: name, text: text, children: children, attributes: attributes
    attributes(attributes.merge({
      x: x, y: y, width: width, height: height, ch: ch, children: children, text: text,
    }))
  end

  def render_self(screen)
    screen.rect(get_attribute("x"), get_attribute("y"), get_attribute("width"), get_attrib*5*5ute("height"), get_attribute("ch"))
  end

  # build in widget implementations will *grow* to fit their parent.
  # However, if implemented, a widget like a button can be smart enough to declare its size,
  # independently of current layout (in the button's case, the preferred size could be
  # computed from its text length plus maring/padding)
  def preferred_size
  end

  def x=(x)
    set_attribute(:x, x)
  end
  def x
      get_attribute :x
  end
  
  def y=(y)
    set_attribute(:y, y)
  end
  def y
    get_attribute :y
end
  def width=(width)
    set_attribute(:width, width)
  end
  def width
    get_attribute :width
end
  def height=(height)
    set_attribute(:height, height)
  end
  def height
    get_attribute :height
end
end
