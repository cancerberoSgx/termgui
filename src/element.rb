require_relative 'node'
require_relative 'style'
require_relative 'renderer'
require_relative 'element_bounds'
require_relative 'element_box'
require_relative 'element_render'
require_relative 'element_style'

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
  include ElementStyle

  def initialize(
    # x: 0,
    # y: 0,
    # width: 0,
    # height: 0,
    # # ch: Pixel.EMPTY_CH,
    # # children: [],
    # # text: '',
    # # attributes: {},
    # name: 'element',
    # style: nil,
    **args
  )
    super
    args[:attributes] = {x: args[:x]||0, y: args[:y]||0, width: args[:width]||0, height: args[:height]||0} if args[:attributes] == nil
    a = {}
    # args[:attributes] args[:attributes]
    a.merge!(args)
    a.merge!(args[:attributes])
    a[:style] = Style.from_hash(args[:attributes][:style] || args[:style] || default_style)
    attributes(a)
    self.style = style if a[:style]
  end

  def ch
    get_attribute('ch')
  end

  # # build in widget implementations will *grow* to fit their parent.
  # # However, if implemented, a widget like a button can be smart enough to declare its size,
  # # independently of current layout (in the button's case, the preferred size could be
  # # computed from its text length plus maring/padding)
  # def preferred_size
  #   { width: abs_width, height: abs_height }
  # end

  # will be called by ActionManager whenever an user input occurs while this element has focus.
  # TODO: move to element_focus module
  def handle_focused_input(event)
    super
  end
end
