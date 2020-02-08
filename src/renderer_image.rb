require_relative 'image'

# takes care rendering png images thanks to chunky_png
module RendererImage
  def image(x: 0, y: 0, image: nil, double_cols: false, ch: ' ', style: Style.new)
    output = []
    image = image.is_a?(String) ? TermGui::Image.new(image) : image
    text = double_cols ? ch + ch : ch
    (y..[y + image.height - 1, height - 1].min).to_a.each do |y2|
      (x..[x + image.width - 1, ((width - 1) * (double_cols ? 0.5 : 1)).to_i].min).to_a.each do |x2|
        style.bg = image.pixel(x2 - x, y2 - y)
        output .push text(x: double_cols ? x2 * 2 : x2, y: y2, text: text, style: style)
      end
    end
    output.join('')
  end
end
