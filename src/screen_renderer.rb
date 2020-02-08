# adds rendering related methods to screen
module ScreenRenderer
  # renders given text at given position
  def text(x: 0, y: 0, text: ' ', style: nil)
    write @renderer.text(x: x, y: y, text: text, style: style)
  end

  def rect(x: 0, y: 0, width: 5, height: 3, ch: Pixel.EMPTY_CH, style: nil)
    write @renderer.rect(x: x, y: y, width: width, height: height, ch: ch, style: style)
  end

  def image(x: 0, y: 0, image: nil, double_cols: false, ch: Pixel.EMPTY_CH, style: Style.new)
    write @renderer.image(x: x, y: y, image: image, double_cols: double_cols, ch: ch, style: style)
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
      text(x: x, y: y + index, text: line, style: style)
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
