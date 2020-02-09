require_relative 'button'
require_relative '../enterable'
require_relative '../log'
require_relative '../cursor'

module TermGui
  module Widget
    # One line text input box, analog to HTMLInputElement
    class InputBox < Button
      include Enterable
      def initialize(**args)
        super
        @name = 'input'
        if args[:dynamic_width]
          on(:input) do |e|
            update_width(e.value)
            cursor.x = abs_content_x + e.value.length - 2
          end
        end
        on(:enter) do
          cursor.enable
        end
        on(:escape) do
          cursor.disable
        end
      end

      def cursor
        @cursor ||= Cursor.new(x: abs_content_x + value.length - 2, y: abs_content_y, enabled: false, screen: root_screen)
        @cursor
      end

      def value=(value)
        @text = value
      end

      def value
        text
      end

      def handle_key(event)
        if !super(event)
          if event.key == 'backspace'
            on_input value.slice(0, [value.length - 1, 0].max), event
            true
          elsif alphanumeric? event.key
            on_input value + event.key, event
            cursor.x = cursor.x + 1
            true
          elsif ['right'].include? event.key
            cursor.x = [cursor.x + 1, abs_content_x + value.length - 1].min
            render
            true
          elsif ['left'].include? event.key
            cursor.x = [cursor.x - 1, abs_content_x - 1].max
            render
            true
          else
            false
          end
        else
          true
        end
      end
    end
  end
end

InputBox = TermGui::Widget::InputBox
