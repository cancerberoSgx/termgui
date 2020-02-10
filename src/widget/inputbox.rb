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
        super({height: 1, text: args[:value]||args[:text] }.merge(args))
        # super
        @name = 'input'
        if args[:dynamic_width]
          on(:input) do |e|
            update_width(e.value)
            cursor.x = abs_content_x + e.value.length - 2
          end
        end
        # set_attribute('escape-on-blur', get_attribute('escape-on-blur') == nil ? true : get_attribute('escape-on-blur'))
        # set_attribute('action-on-focus', get_attribute('action-on-focus') == nil ? true : get_attribute('action-on-focus'))
        on(:enter) do
          cursor.enable
        end
        on(:escape) do
          cursor.disable
          args[:change]&.call(value)
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

      def between(v, min, max)
        [[v, min].max, max].min
      end

      def current_x
        cursor.x - abs_content_x
      end

      def handle_key(event)
        if !super(event)
          if event.key == 'backspace'
            on_input value[0..between(current_x - 1, 0, value.length - 1)] + value[between(current_x + 1, 0, value.length - 1)..(value.length - 1)], event
            cursor.x = [cursor.x - 1, abs_content_x - 1].max
            render
            true
          elsif alphanumeric? event.key
            on_input value[0..between(current_x, 0, value.length - 1)] + event.key + value[between(current_x + 1, 0, value.length - 1)..(value.length - 1)], event
            cursor.x = cursor.x + 1
            render
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

# p 'sdfsdf'[0..3]
