require_relative 'button'
require_relative '../enterable'
require_relative '../log'
require_relative 'checkbox'

module TermGui
  module Widget
    class SelectOption < CheckBox
      def initialize(**args)
        super
        @name = 'select-option'
        set_attribute('focusable', false)
      end
    end

    # One line text input box, analog to HTMLInputElement
    class SelectBox < Button
      include Enterable
      def initialize(**args)
        super
        @name = 'select'
        set_attribute('escape-on-blur', get_attribute('escape-on-blur') == nil ? true : get_attribute('escape-on-blur'))
        set_attribute('action-on-focus', get_attribute('action-on-focus') == nil ? true : get_attribute('action-on-focus'))
        @options = (args[:options] || [])
        @option_elements = @options.map.with_index do |o, i|
          SelectOption.new(
            text: o[:text] || o[:value],
            value: o[:selected] || false,
            parent: self,
            y: i + 1,
            x: 0
          )
        end
        render_options 0
      end

      def render_options(c = nil)
        @current = c unless c == nil
        @option_elements.each_with_index do |e, i|
          e.style.bg = 'red' if i == @current
          e.style.bg = 'black' if i != @current
          e.render
        end
      end

      def value
        @option_elements.map.with_index { |e, i| e.value ? @options[i][:value] : nil }.reject { |v| v == nil }
      end

      def value=(v)
        # todo
        # throw 'todo'
      end

      def handle_key(event)
        if !super(event)
          if event.key == 'up'
            render_options [@current - 1, 0].max
            true
          elsif event.key == 'down'
            render_options [@current + 1, @option_elements.length - 1].min
            true
          elsif ['space'].include? event.key
            @option_elements[@current].value = !@option_elements[@current].value
            on_input value, event
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

SelectBox = TermGui::Widget::SelectBox

# sb=nil
# s = Screen.new(children: [
#   Button.new(text: 'hello', x: 0.7, y: 0.6, action: proc {|e|
#     e.target.text = sb.value.join(', ')
#     e.target.render
#   }),
# (sb = SelectBox.new(x: 2, y: 1, width: 0.5, height: 0.5, options:
# [
#   {
#     text: '1', value: 1, selected: true
#   }, {
#     text: '2', value: 2
#   }, {
#     text: '3', value: 3
#   }
# ]))
# ])

# s.start
