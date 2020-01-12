require_relative 'event'
require_relative 'emitter'

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
  def initialize(focus, input)
    super()
    @focus = focus
    @input = input
    @input.subscribe('key', proc { |e|
      handle_key e
    })
    install(:action)
  end

  def handle_enter(e)
    focused = @focus.focused
    # p 'action'+focused.to_s
    if focused&.get_attribute('focusable')
      event = ActionEvent.new focused, e
      focused_action = focused.get_attribute('action')
      focused_action&.call(event) 
      # log 'handle_enter'+event.name
      trigger event.name, event
      focused.trigger event.name, event
      # handle_enter(event)
    end
  end

  def handle_key(e)
    is_enter = e.key == '\\r'
    # log "#{is_enter}"
    handle_enter e if is_enter
    # p e
    # @focus.focused&.handle_focused_input e
  end
end

class ActionEvent < NodeEvent
  def initialize(target, original_event)
    super 'action', target, original_event
  end
end
