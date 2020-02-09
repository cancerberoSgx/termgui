require_relative 'node'
require_relative 'style'
require_relative 'renderer'
require_relative 'element_bounds'
require_relative 'element_box'
require_relative 'element_render'
require_relative 'element_style'

module TermGui
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

    def initialize(**args)
      super
      install(%i[focus blur action enter escape])
      args[:attributes] = { x: args[:x] || 0, y: args[:y] || 0, width: args[:width] || 0, height: args[:height] || 0 } if args[:attributes] == nil
      a = {}.merge(args, args[:attributes] || {})
      # a.merge!(args)
      # a.merge!(args[:attributes] || {})
      a[:style] = default_style.assign(Style.from_hash(a[:attributes][:style])).assign(Style.from_hash(a[:style]))
      self.attributes = a
      self.style = a[:style]
      on(%i[focus blur action enter escape]) do |e|
        if e.name == 'action'
          set_attribute('actioned', true)
          render
          root_screen&.set_timeout(get_attribute('actioned-interval') || 0.2) do
            set_attribute('actioned', false)
            render
          end
        else
          render
        end
      end
    end

    def focus
      root_screen&.focus&.focused = self if get_attribute('focusable')
    end
  end
end

Element = TermGui::Element
