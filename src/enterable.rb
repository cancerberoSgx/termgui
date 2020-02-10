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

  class EnterEvent < NodeEvent
    def initialize(target, original_event = nil)
      super 'enter', target, original_event
    end
  end

  module Enterable
    def initialize(**args)
      super
      self.value = args[:value] || ''
      @key_listener = nil
      set_attribute(:focusable, true)
      set_attribute(:enterable, true)
      set_attribute(:actionable, true)
      install(%i[input action enter change escape focus blur])
      on(:action) do |event|
        return unless root_screen && get_attribute('entered')
        set_attribute('entered', true)
        @key_listener = proc { |e| handle_key e }
        root_screen.event.add_any_key_listener @key_listener
        on('change', args[:change]) if args[:change]
        on('input', args[:input]) if args[:input]
        on('escape', args[:escape]) if args[:escape]
        trigger('enter', EnterEvent.new(self, event))
      end
      on(%i[blur escape change]) do
        return unless root_screen
        set_attribute('entered', false)
      end
    end

    def handle_key(event)
      return unless root_screen
      if !get_attribute('focused')
        trigger('change', ChangeEvent.new(self, value, event))
        root_screen.event.remove_any_key_listener @key_listener
        true
      elsif to_array(get_attribute('escape-keys') || 'escape').include? event.key
        trigger('escape', EscapeEvent.new(self, event))
        root_screen.event.remove_any_key_listener @key_listener
        true
      else
        false
      end
    end

    def value=(_value)
      throw 'subclass must implementation'
    end

    def value
      throw 'subclass must implementation'
    end

    protected

    def on_input(value, event = nil)
      return unless root_screen
      self.value = value
      trigger('input', InputEvent.new(self, value, event))
    end
  end
end

Enterable = TermGui::Enterable
InputEvent = TermGui::InputEvent
ChangeEvent = TermGui::ChangeEvent
EscapeEvent = TermGui::EscapeEvent
