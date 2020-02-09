require_relative 'button'
require_relative '../log'
require_relative '../util'
require_relative '../screen'

module TermGui
  module Widget
    # Similar to HTMLInputElement type="checkbox"
    class CheckBox < Button
      def initialize(**args)
        super
        @name = 'checkbox'
        set_attribute('action-keys', %w[enter space])
        set_attribute('label', text || get_attribute('label') || unique('Option'))
        update_text get_attribute('value') || get_attribute('checked') || args[:value] || args[:checked] || false
        on(:action) do |e|
          update_text !get_attribute('value')
          render
          trigger(:input, TermGui::InputEvent.new(self, value, e))
          trigger(:change, TermGui::ChangeEvent.new(self, value, e))
        end
      end

      def value
        get_attribute('value')
      end

      def value=(v)
        update_text v
      end

      def update_text(v = nil)
        set_attribute('value', v) unless v == nil
        self.text = "#{get_attribute('value') ? '[x]' : '[ ]'} #{get_attribute('label')}"
      end

      def default_style
        s = super
        s.border = nil
        s.action = nil
        s
      end
    end
  end
end

CheckBox = TermGui::Widget::CheckBox
