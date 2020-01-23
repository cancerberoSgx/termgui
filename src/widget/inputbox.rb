require_relative 'button'
require_relative '../enterable'
require_relative '../log'

module TermGui
  module Widget
    # One line text input box, analog to HTMLInputElement
    class InputBox < Button
      include Enterable
      def initialize(**args)
        super
        @name = 'input'
        install(:input)
        if args[:dynamic_width]
          on(:input) do |e|
            update_width(e.value)
          end
      end
      end
    end
  end
end

InputBox = TermGui::Widget::InputBox
