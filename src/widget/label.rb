require_relative '../element'

# A label widget. It's size, if not given, will be computed according to its text.
class Label < Element
  def initialize(*args)
    super *args
    @name = 'label'
    w = args[0][:width]
    self.width = render_text_size[:width] if !w || w == 0
    h = args[0][:height]
    self.height = render_text_size[:height] if !h || h == 0
  end
end
