require_relative 'node'

class Element < Node
  def initialize(x: 0, y: 0, width: 0, height: 0, ch: Pixel.EMPTY_CH, children: [], text: "", name: "element", attributes: {})
    super name: name, text: text, children: children, attributes: attributes
    attributes(attributes.merge({
      x: x, y: y, width: width, height: height, ch: ch, children: children, text: text,
    }))
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
