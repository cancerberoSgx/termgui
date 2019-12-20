require_relative '../element'

# A button widget
# Button.new(text: 'click me', style: {bg: 'blue'}, action: proc {|e| p 'actioned!'})
class Label < Element
  def initialize(*args)
    super args
    @name = 'label'
    @width = render_text_size[:width] unless @width&.positive?
    @height = render_text_size[:height] unless @height&.positive?
  end

end
