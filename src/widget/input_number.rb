require_relative 'button'
require_relative '../enterable'
require_relative '../util'
require_relative '../screen'

module TermGui
  module Widget
    # analog to HTMLInputElement type="number"
    class InputNumber < Button
      include Enterable
      def initialize(**args)
        super
        @name = 'input-number'
        set_attribute('escape-on-blur', get_attribute('escape-on-blur') == nil ? true : get_attribute('escape-on-blur'))
        set_attribute('action-on-focus', get_attribute('action-on-focus') == nil ? true : get_attribute('action-on-focus'))
      end

      def value
        v = parse_float(text)
        v == nil ? v : (v.to_i - v == 0 ? v.to_i : v)
      end

      def value=(v)
        self.text = v.to_s
      end

      def handle_key(event)
        if !super(event)
          if event.key == 'up'
            on_input value + 1, event
            true
          elsif event.key == 'down'
            on_input value - 1, event
            true
          elsif numeric? event.key
            self.text = text + event.key
            if parse_float(text) == nil
              render
            else
              on_input value, event
            end
            true
          elsif event.key == 'backspace'
            self.text = text.slice(0, [text.length - 1, 0].max)
            if parse_float(text) == nil
              render
            else
              on_input value, event
            end
            true
          end
        else
          true
        end
      end
    end
  end
end

InputNumber = TermGui::Widget::InputNumber

# # p parse_float('9.')

# sb = nil
# s = Screen.new(children: [
#                  Button.new(text: 'hello', x: 0.7, y: 0.6, action: proc { |e|
#                    e.target.text = sb.value.to_s
#                    e.target.render
#                  }),
#                  (sb = InputNumber.new(x: 2, y: 1, width: 0.5, height: 0.5, value: 12))
#                ])

# s.start
