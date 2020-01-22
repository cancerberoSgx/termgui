require_relative 'event'

module TermGui
  class InputEvent < NodeEvent
    attr_accessor :value
    def initialize(target, value = target.value, original_event = nil)
      super 'input', target, original_event
      @value = value
    end
  end

  class ChangeEvent < NodeEvent
    attr_accessor :value
    def initialize(target, value = target.value, original_event = nil)
      super 'change', target, original_event
      @value = value
    end
  end

  class EscapeEvent < NodeEvent
    def initialize(target, original_event = nil)
      super 'escape', target, original_event
    end
  end

  module Enterable
    attr_accessor :value

    def initialize(**args)
      super
      @value = args[:value] || ''
      @key_listener = nil
      install(:input)
      install(:change)
      install(:escape)
      on(:action) do
        @key_listener = proc { |e| on_key e }
        root_screen.event.add_any_key_listener @key_listener
        on('change', args[:change]) if args[:change]
        on('input', args[:input]) if args[:input]
        on('escape', args[:escape]) if args[:escape]
      end
    end

    def on_key(event)
      if !get_attribute('focused')
        trigger('change', ChangeEvent.new(self, @value, event))
        root_screen.event.remove_any_key_listener @key_listener
      elsif event.key == 'escape'
        trigger('escape', EscapeEvent.new(self, event))
        root_screen.event.remove_any_key_listener @key_listener
      elsif event.key == 'backspace'
        on_input @value.slice(0, @value.length - 1), event
      elsif alphanumeric? event.key
        on_input @value + event.key, event
      end
    end

    protected

    def on_input(value, event = nil)
      @value = value
      self.text = @value
      update_width
      root_screen.clear
      root_screen.render
      trigger('input', ChangeEvent.new(self, @value, event))
    end
  end
end

Enterable = TermGui::Enterable
InputEvent = TermGui::InputEvent
ChangeEvent = TermGui::ChangeEvent
EscapeEvent = TermGui::EscapeEvent
