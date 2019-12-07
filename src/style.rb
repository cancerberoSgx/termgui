require_relative "color"

# refers only to properties direct=ly implemented using ansi escape codes
# responsible of printing escape ansi codes for style
class Style
  attr :fg, :bg

  def initialize(fg=nil, bg=nil)
    @fg = fg
    @bg = bg
  end

  def assign(style)
    @fg = style.fg || @fg
    @bg = style.bg || @bg
  end

  def equals(style)
    @bg == style.bg && @fg == style.fg
  end

  def print
    color @fg, @bg
  end

  def reset
    @bg = @fg = nil
  end
  
end
