require_relative '../element'

# A button widget
# Button.new(text: 'click me', style: {bg: 'blue'}, action: proc {|e| p 'actioned!'})
class Button < Element
  def initialize(*args)
    super args
    @name = 'button'
    install(:action)
    add_listener(:action, args[:action]) if args[:action]
    self.style = default_style.clone
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
