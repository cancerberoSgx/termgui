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
        s.border = Border.new(fg: '#779966')
        s.bg = '#336688'
        s.fg = '#111111'
        s.focus&.fg = 'red'
        s.focus.bold = true
        s.focus.underline = true
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
