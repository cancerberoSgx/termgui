require_relative "node"
require_relative "style"
require_relative "renderer"

# Node responsible of x, y, width, height, abs_x, abs_y
class Element < Node
  def initialize(x: 0, y: 0, width: 0, height: 0, ch: Pixel.EMPTY_CH, children: [], text: "", name: "element", attributes: {})
    # attributes.set_attribute("style", attributes.get_attribute("style")
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
      width: get_attribute("width"),
      height: get_attribute("height"),
      ch: get_attribute("ch"),
    )
  end

  # build in widget implementations will *grow* to fit their parent.
  # However, if implemented, a widget like a button can be smart enough to declare its size,
  # independently of current layout (in the button's case, the preferred size could be
  # computed from its text length plus maring/padding)
  def preferred_size
  end

  def x=(x)
    set_attribute("x", x)
  end

  def x
    get_attribute("x")
  end

  def abs_x
    (@parent ? @parent.abs_x : 0) + x
  end

  def y=(y)
    set_attribute("y", y)
  end

  def y
    get_attribute "y"
  end

  def abs_y
    (@parent ? @parent.abs_y : 0) + y
  end

  def width=(width)
    set_attribute("width", width)
  end

  def width
    get_attribute "width"
  end

  def self.is_precent(val)
    val > 0 && val < 1
  end

  def abs_width
    width = get_attribute "width"
    width = width || 0
    if (Element.is_precent width) && @parent
      @parent.abs_width * width
    else
      width
    end
  end

  def height=(height)
    set_attribute("height", height)
  end

  def height
    get_attribute "height"
  end

  def abs_height
    height = get_attribute "height"
    height = height || 0
    if Element.is_precent height
      @parent ? @parent.abs_height * height : 0
    else
      height
    end
  end
end

# e = Element.new(x: 1, y: 2, width: 16, height: 12)
# e1 = Element.new(x: 0.3, y: 0.2, width: 0.6, height: 0.8)
# e.append_child(e1)
# # p e1.abs_width
# # assert_equal 9.6, e1.abs_width
# p e1.abs_height, e1.abs_y, e1.abs_x
 