require_relative 'geometry'

# so screen emulates an Element. TODO: make Screen < Element and get rid of width and height and all of this...
module ScreenElement
  # complies with Element#render and also is capable of rendering given elements
  def render(element = nil)
    if element == self || element.nil?
      children.each { |child| child.render self }
    elsif !element.nil?
      element.render self
    end
  end

  def abs_x
    0
  end

  def abs_y
    0
  end

  def abs_width
    @width
  end

  def style
    @style ||= Style.new
    @style
  end

  def style=(s)
    @style = s
  end

  def final_style
    style
  end

  def offset
    v = get_attribute('offset')
    unless v
      v = Offset.new
      set_attribute('offset', v)
    end
    v
  end

  def offset=(value)
    set_attribute('offset', value)
  end

  def abs_height
    @height
  end

  def root_screen
    self
  end
end
