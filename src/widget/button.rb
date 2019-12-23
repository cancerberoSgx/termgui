require_relative 'label'

# A button widget
# Button.new(text: 'click me', style: {bg: 'blue'}, action: proc {|e| p 'actioned!'})
class Button < Label
  def initialize(*args)
    super args
    @name = 'button'
    install(:action)
    add_listener(:action, args[:action]) if args[:action]
    set_attribute('focusable', true)
  end

  def default_style
    s = super
    s.border = Border.new
    s.focus.fg = 'red'
    s
  end

  def handle_focused_input(event)
    p event
  end

  def preferred_size
  end
end
