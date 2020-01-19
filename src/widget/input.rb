require_relative 'label'
module TermGui
  module Widget
    # A button widget
    # Button.new(text: 'click me', style: {bg: 'blue'}, action: proc {|e| p 'actioned!'})
    class Input < Label
      def initialize(**args)
        super
        @name = 'input'
        install(:action)
        install(:input)
        add_listener(:action, args[:action]) if args[:action]
        add_listener(:input, args[:input]) if args[:input]
        set_attribute('focusable', true)
      end

      def default_style
        s = super
        s.border = Border.new
        s.focus.fg = 'red'
        s
      end

      def handle_focused_input(event)
        # p event
      end

      def preferred_size
      end
    end
end
end

Input = TermGui::Widget::Input
