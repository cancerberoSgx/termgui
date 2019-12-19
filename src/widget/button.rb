require_relative '../element'

# A button widget
# Button.new(text: 'click me', style: {bg: 'blue'}, action: proc {|e| p 'actioned!'})
class Button < Element
  def initialize(*args)
    super args
    on(:action)
    add_listener(:action, args[:action]) if args[:action]
  end

  def handle_focused_input(event)
    p event
  end
end
