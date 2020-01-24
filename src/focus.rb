require_relative 'emitter'
require_relative 'element'
require_relative 'log'
require_relative 'event'

module TermGui
  # provides support for focused, focusable attributes management and emit focus-related events
  # TODO: make events extend NodeEvent
  class FocusManager < Emitter
    attr_reader :keys, :focused

    def initialize(
      root: nil, # the root element inside of which to look up for focusables
      event: nil, # EventManager instance - needed for subscribe to key events
      keys: { next: ['tab'], prev: ['S-tab'] }, # the keys for focusing the next and previous focusable
      focus_first: true # if true will set focus (attribute focused == true) on the first focusable automatically
    )
      throw 'root Element and Event EventManager are required' unless root && event
      install(:focus)
      @root = root
      @keys = keys
      @event = event
      @focus_first = focus_first
      init
      @event.add_any_key_listener { |e| handle_key e }
      @root.on(:after_start) do
        init
      end
    end

    def init
      focusables.each { |n| n.set_attribute(:focused, false) }
      if @focus_first
        self.focused = focusables.first
        @focused&.render if @focused6.is_a? Element
      end
    end

    def focusables
      @root.query_by_attribute(:focusable, true)
    end

    # focus next focusable node
    def focus_next
      i = focusables.index(@focused) || 0
      new_i = i == focusables.length - 1 ? 0 : i + 1
      self.focused = focusables[new_i] if focusables[new_i]
    end

    # focus previous focusable node
    def focus_prev
      i = focusables.index(@focused) || 0
      new_i = i.zero? ? focusables.length - 1 : i - 1
      self.focused = focusables[new_i] if focusables[new_i]
    end

    def focused=(focused)
      previous = @focused
      @focused&.set_attribute(:focused, false)
      @focused = focused
      @focused&.set_attribute(:focused, true)
      emit :focus, focused: @focused, previous: previous
      previous&.emit :blur, BlurEvent.new(previous, @focused)
      @focused&.emit :focus, FocusEvent.new(@focused, previous)
    end

    protected

    def handle_key(e)
      return if @focused&.get_attribute('entered')

      if @keys[:next].include? e.key
        focus_next
      elsif @keys[:prev].include? e.key
        focus_prev
      end
    end
  end

  class BlurEvent < NodeEvent
    attr_accessor :focused
    def initialize(target, focused, original_event = nil)
      super 'blur', target, original_event
      @focused = focused
    end
  end

  class FocusEvent < NodeEvent
    attr_accessor :previous
    def initialize(target, previous, original_event = nil)
      super 'focus', target, original_event
      @previous = previous
    end
  end
end

FocusManager = TermGui::FocusManager
