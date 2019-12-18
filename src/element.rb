require_relative "node"
require_relative "style"
require_relative "renderer"
require_relative "element_bounds"

# Node responsible of 
#  * x, y, width, height, abs_x, abs_y
#  * rendering text, wrap (TODO)
#  * border, margin & padding & abs_* update (TODO)
#  * scroll
# TODO: separate each responsibility on its module or subclass
class Element < Node

  include ElementBounds
  
  def initialize(x: 0, y: 0, width: 0, height: 0, ch: Pixel.EMPTY_CH, children: [], text: "", name: "element", attributes: {})
    super(name: name, text: text, children: children, attributes: attributes)
    attributes(attributes.merge({
      x: x, y: y, width: width, height: height, ch: ch, style: attributes[:style] || Style.new,
    }))
  end

  def style
    get_attribute("style")
  end

  def style=(style)
    s = style.instance_of?(Hash) ? Style.from_hash(style) : style
    set_attribute("style", s)
  end

  def style_assign(style)
    get_attribute("style").assign(style)
  end

  def render_self(screen)
    screen.style = style if style
    screen.rect(
      x: abs_x,
      y: abs_y,
      width: abs_width,
      height: abs_height,
      ch: ch,
    )
  end

  def ch
    get_attribute("ch")
  end

  # build in widget implementations will *grow* to fit their parent.
  # However, if implemented, a widget like a button can be smart enough to declare its size,
  # independently of current layout (in the button's case, the preferred size could be
  # computed from its text length plus maring/padding)
  def preferred_size
  end

end
