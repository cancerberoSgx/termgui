require_relative 'event'
require_relative 'emitter'
require_relative 'util'

module TermGui
  # action manager - it notifies focused elements on user input
  # WIP
  # defines action concept semantics like "action", "input"
  # "focus": user press tab and it set focus on the next focusable element
  # "enter": user focus a button and press enter or space. The button will receive an "action" event.
  # "input": user focus a textarea, press enter ("action") and this enters in the "edit" mode
  # meaning all user input now it's being notified ONLY to the textarea. Nor even the focus manager or
  # others will be notified.
  # "escape": when in a textarea "edit" mode, user press ESCAPE to exit it, meaning now user input will
  # be notified to all listeners. Example: when in edit mode, pressing TAB will just print a tab in the
  # textarea and it won't change focus as usual. For that to happen user presses escape to exit the "edit" mode.
  # Attributes enabling each action:
  # "enterable"
  # "focusable"
  # in the case of scape it will be enabled iff enterable is true
  # For example a Label is not focusable or enterable. A Button is focusable but not enterable. A textatra is focusable and enterable.
  class ActionManager < Emitter
    attr_accessor :keys

    def initialize(event: nil, focus: nil)
      super()
      @event = event
      @focus = focus
      @event.add_any_key_listener { |e| handle_key e }
      install(:action)
      @keys = ['enter']
    end

    def handle_key(e)
      focused = @focus.focused
      return unless focused && !focused.get_attribute('entered')

      action_keys = to_array(focused.get_attribute('action-keys') || keys)
      if (action_keys.include? e.key) && focused.get_attribute('focusable')
        event = ActionEvent.new focused, e
        focused_action = focused.get_attribute('action')
        focused_action&.call(event)
        trigger event.name, event
        focused.trigger event.name, event
      end
    end
  end

  # An event representing an action, like a button "clicked"
  class ActionEvent < NodeEvent
    def initialize(target, original_event)
      super 'action', target, original_event
    end
  end
end

ActionEvent = TermGui::ActionEvent
ActionManager = TermGui::ActionManager
