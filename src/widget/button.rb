require_relative 'label'

module TermGui
  module Widget
    # A button widget. Usage:
    # Button.new(text: 'click me', style: {bg: 'blue'}, action: proc {|e| p 'actioned!'})
    class Button < Label
      def initialize(**args, &block)
        super
        @name = 'button'
        install(:action)
        # the_block = args[:action] == nil ? block : args[:action]
        # throw 'Action block not given' unless the_block
        # add_listener(:action, args[:action]) if the_block
        set_attribute(:focusable, true)
      end

      def default_style
        s = super
        s.border = Border.new(fg: 'red')
        s.bg = 'white'
        s.fg = 'blue'
        s.focus.fg = 'green'
        s.focus.bg = 'blue'
        s.focus.border = Border.new(fg: 'green')
        s
      end
    end
  end
end

Button = TermGui::Widget::Button
