require_relative '../element'

# A label widget. It's size, if not given, will be computed according to its text.
class Label < Element
  def initialize(**args)
    super
    @name = 'label'
    # sets width and height according to size rendering:
    w = args[:width] || 0
    # w = w + 2 if w != nil && style.border
    self.width = render_text_size[:width] if !w || w.zero?
    h = args[:height] || 0
    # h = h + 2 if h != nil && style.border
    self.height = render_text_size[:height] if !h || h.zero?
  end
end
