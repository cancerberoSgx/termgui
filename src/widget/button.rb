require_relative 'label'

# A button widget. Usage:
# Button.new(text: 'click me', style: {bg: 'blue'}, action: proc {|e| p 'actioned!'})
class Button < Label
  def initialize(**args, &block)
    super
    @name = 'button'
    install(:action)
    the_block = args[:action]==nil ? block : args[:action]
    # throw 'Action block not given' unless the_block
    add_listener(:action, args[:action]) if the_block
    set_attribute(:focusable, true)
  end

  def default_style
    s = super
    s.border = Border.new
    s.focus.fg = 'red'
    s
  end

end
