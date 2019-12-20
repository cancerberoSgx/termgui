require_relative 'node'
require_relative 'style'
require_relative 'renderer'
require_relative 'element_bounds'
require_relative 'element_box'
require_relative 'element_render'

# Node responsible of
#  * x, y, width, height, abs_x, abs_y
#  * rendering text, wrap (TODO)
#  * border, margin & padding & abs_* update (TODO)
#  * scroll
# TODO: separate each responsibility on its module or subclass
class Element < Node
  include ElementBounds
  include ElementBox
  include ElementRender

  def initialize(x: 0, y: 0, width: 0, height: 0, ch: Pixel.EMPTY_CH, children: [], text: '', name: 'element',
                 margin: Offset.new, padding: Offset.new, attributes: {})
    super(name: name, text: text, children: children, attributes: attributes)
    attributes(attributes.merge(x: x, y: y, width: width, height: height, ch: ch,
                                margin: margin, padding: padding, style: attributes[:style] || Style.new))
  end

  def style
    get_attribute('style')
  end

  def style=(style)
    s = style.instance_of?(Hash) ? Style.from_hash(style) : style
    set_attribute('style', s)
  end

  def style_assign(style)
    get_attribute('style').assign(style)
  end

  def ch
    get_attribute('ch')
  end

  def default_style
    style
  end

  # build in widget implementations will *grow* to fit their parent.
  # However, if implemented, a widget like a button can be smart enough to declare its size,
  # independently of current layout (in the button's case, the preferred size could be
  # computed from its text length plus maring/padding)
  def preferred_size
    { width: abs_width, height: abs_height }
  end

  # will be called by ActionManager whenever an user input occurs while this element has focus.
  # TODO: move to element_focus module
  def handle_focused_input(event)
    super
  end
end
