require_relative '../element'

# A button widget
# Button.new(text: 'click me', style: {bg: 'blue'}, action: proc {|e| p 'actioned!'})
class Label < Element
  def initialize(*args)
    super *args
    @name = 'label'
    p args
    w = args[0][:width]
    h = args[0][:height]
    p w, h
    if !w || w==0
      p 'hacking width'
      self.width = render_text_size[:width]
    end
    if !h || height==0
      p 'hacking height', render_text_size
      self.height = render_text_size[:height]
    end
    # self.height = render_text_size[:height] unless @height&.positive?
    # p @width, @height, render_text_size, abs_width, abs_height
  end
end
