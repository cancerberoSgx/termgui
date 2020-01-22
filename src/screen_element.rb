require_relative 'geometry'

# so screen emulates an Element. TODO: make Screen < Element and get rid of width and height and all of this...
module ScreenElement
  def abs_x
    0
  end

  def abs_y
    0
  end

  def abs_width
    @width
  end

  def offset
    @offset = Offset.new if !@offset
    @offset
  end

  def abs_height
    @height
  end

  def root_screen
    self
  end
end
