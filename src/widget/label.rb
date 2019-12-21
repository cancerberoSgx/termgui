require_relative '../element'

# A button widget
# Button.new(text: 'click me', style: {bg: 'blue'}, action: proc {|e| p 'actioned!'})
class Label < Element
  def initialize(*args)
    super *args
    @name = 'label'
    # style.wrap=true
    # style.wrap = args[0][:style] ? args[0][:style].wrap : false

    w = args[0][:width]
    if !w || w==0
      self.width = render_text_size[:width]
    end

    h = args[0][:height]
    if !h || h==0
      self.height = render_text_size[:height]
    end
  end
end
