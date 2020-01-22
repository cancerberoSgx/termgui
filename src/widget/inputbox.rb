require_relative 'button'
require_relative '../enterable'

module TermGui
  module Widget
    # One line text input box, analog to HTMLInputElement
    class InputBox < Button
      include Enterable
      def initialize(**args)
        super
        @name = 'input'
      end
    end
  end
end

InputBox = TermGui::Widget::InputBox
