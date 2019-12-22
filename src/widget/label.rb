require_relative '../element'

# A label widget. It's size, if not given, will be computed according to its text. 
class Label < Element
  def initialize(*args)
    super *args
    @name = 'label'
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
