# adds rendering related methods to screen
module ScreenRenderer
  # renders given text at given position
  def text(x: nil, y: nil, text: ' ', style: nil)
    write @renderer.write(x, y, text, style)
  end

  def rect(x: 0, y: 0, width: 5, height: 3, ch: Pixel.EMPTY_CH, style: nil)
    renderer.style = style if style
    write @renderer.rect x: x, y: y, width: width, height: height, ch: ch
  end

  def clear
    @renderer.style = Style.new
    write @renderer.style.print
    write @renderer.clear
  end

  def style=(style)
    @renderer.style = style
    write @renderer.style.print
  end

  def box(x, y, width, height, border_style = :classic, style = nil)
    self.style = style if style
    box = draw_box(width: width, height: height, style: border_style)
    box.each_with_index do |line, index|
      text(x: x, y: y + index, text: line)
    end
  end

  def print
    @renderer.print
  end

  def cursor_move(x, y)
    write @renderer.move(x, y)
  end

  def cursor_show
    write @renderer.cursor_show
  end

  def cursor_hide
    write @renderer.cursor_hide
  end
end
