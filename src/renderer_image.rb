require_relative 'image'

# takes care rendering given Images
module RendererImage
  # renders given Image or file path at given x, y coords. Currently only PNG format supported.
  # by default bg attribute is used and space is printed for each pixel but this could be configured using fg, bg, and ch
  def image(x: 0, y: 0, image: nil, ch: ' ', style: Style.new, fg: false, bg: true, h: height - y, w: width - w,
            transparent_color: nil) # if a [r,g,b] color is given, then alpha channel will be considered to mix colors accordingly
    output = []
    image = image.is_a?(String) ? TermGui::Image.new(image) : image
    (y..[y + image.height - 1, height - 1].min).to_a.each do |y2|
      (x..[x + image.width - 1, width - 1].min).to_a.each do |x2|
        pixel = image.rgb(x2 - x, y2 - y, transparent_color)
        style.bg = pixel if bg
        style.fg = pixel if fg
        output .push text(x: x2, y: y2, text: ch, style: style) if x2 < w && y2 < h
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
