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
    # attr_accessor :value
    def initialize(target, value = target.value, original_event = nil)
      super 'change', target, original_event
      # @value = value
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
      install(:input)
      install(:action)
      install(:enter)
      install(:change)
      install(:escape)
      on(:action) do |event|
        unless get_attribute('entered')
          set_attribute('entered', true)
          @key_listener = proc { |e| handle_key e }
          root_screen.event.add_any_key_listener @key_listener
          on('change', args[:change]) if args[:change]
          on('input', args[:input]) if args[:input]
          on('escape', args[:escape]) if args[:escape]
          trigger('enter', EnterEvent.new(self, event))
        end
      end
      on([:blur, :escape, :change]) do 
        set_attribute('entered', false)
      end
    end

    def handle_key(event)
      if !get_attribute('focused')
        trigger('change', ChangeEvent.new(self, value, event))
        root_screen.event.remove_any_key_listener @key_listener
        true
      elsif event.key == 'escape'
        trigger('escape', EscapeEvent.new(self, event))
        root_screen.event.remove_any_key_listener @key_listener
        true
      elsif event.key == 'backspace'
        on_input value.slice(0, value.length - 1), event
        true
      elsif alphanumeric? event.key
        on_input value + event.key, event
        true
      else
        false
      end
    end

    # def value=(value)
    #   # @value = value
    #   throw 'subclass must implementation'
    # end

    # def value
    #   # @value
    #   throw 'subclass must implementation'
    # end

    protected

    def on_input(value, event = nil)
      self.value = value
      # self.text = self.value
      root_screen.clear # TODO: performance
      root_screen.render
      trigger('input', InputEvent.new(self, value, event))
    end
  end
end

Enterable = TermGui::Enterable
InputEvent = TermGui::InputEvent
ChangeEvent = TermGui::ChangeEvent
EscapeEvent = TermGui::EscapeEvent
