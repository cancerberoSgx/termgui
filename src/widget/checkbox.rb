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
        set_attribute('action-keys', ['enter', 'space'])
        set_attribute('label', text || get_attribute('label') || unique('Option'))
        set_attribute('value', get_attribute('value') || get_attribute('checked') || args[:value] || args[:checked] || false)
        update_text
        on(:action) do
          set_attribute('value', !get_attribute('value'))
          update_text
          render
        end
      end

      def update_text
        self.text = "#{get_attribute('value') ? '[x]' : '[ ]'} #{get_attribute('label')}"
      end
    end
  end
end

CheckBox = TermGui::Widget::CheckBox

s = Screen.new

s.append_child CheckBox.new(x: 2, y: 2, text: 'select me')
s.append_child CheckBox.new(x: 2, y: 6, text: 'select 2')
s.start
