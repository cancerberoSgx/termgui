require_relative 'image'

# takes care rendering given Images
module RendererImage
  # renders given Image or file path at given x, y coords. Currently only PNG format supported.
  # @param double_cols if true each pixel will be 2 columns width (so they look like more squares)
  # by default bg attribute is used and space is printed for each pixel but this could be configured using fg, bg, and ch
  # TODO
  #  * alpha is it possible (see blessed) ?
  #  * should we ignore alpha=0 pixels (don't paint them ?)
  def image(x: 0, y: 0, image: nil, double_cols: false, ch: ' ', style: Style.new, fg: false, bg: true)
    ch = ch || ' '
    output = []
    image = image.is_a?(String) ? TermGui::Image.new(image) : image
    text = double_cols ? ch + ch : ch
    (y..[y + image.height - 1, height - 1].min).to_a.each do |y2|
      (x..[x + image.width - 1, ((width - 1) * (double_cols ? 0.5 : 1)).to_i].min).to_a.each do |x2|
        style.bg = image.pixel(x2 - x, y2 - y) if bg
        style.fg = image.pixel(x2 - x, y2 - y) if fg
        output .push text(x: double_cols ? x2 * 2 : x2, y: y2, text: text, style: style)
      end
    end
    output.join('')
  end

  private

  def mix_colors(fg, bg, alpha = 0.5)
    r = (fg[0] * alpha + bg[0] * (1 - alpha)).to_i
    g = (fg[1] * alpha + bg[1] * (1 - alpha)).to_i
    b = (fg[2] * alpha + bg[2] * (1 - alpha)).to_i
    [r, g, b]
  end
end
