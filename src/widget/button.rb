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
        set_attribute(:focusable, true)
      end

      def default_style
        s = super
        s.border = Border.new(fg: 'red')
        s.bg = 'black'
        s.fg = 'blue'
        s.focus&.fg = 'green'
        s.focus&.bg = 'grey'
        s.focus&.border = Border.new(fg: 'green')
        s.action&.bg = 'red'
        s.action&.border = Border.new(fg: 'magenta', bold: true, bg: 'white')
        s
      end
    end
  end
end

Button = TermGui::Widget::Button
