require 'chunky_png'
require_relative '../src/screen'

def pixel(image, x, y)
  p = image[x, y]
  [ChunkyPNG::Color.r(p), ChunkyPNG::Color.g(p), ChunkyPNG::Color.b(p)]
end

def draw(image: nil, screen: nil, double_cols: true, ch: ' ')
  image = image.is_a?(String) ? ChunkyPNG::Image.from_file(image) : image
  (0..[image.height - 1, screen.height - 1].min).to_a.each do |y|
    (0..[image.width - 1, ((screen.width - 1) * (double_cols ? 0.5 : 1)).to_i].min).to_a.each do |x|
      color = pixel(image, x, y)
      screen.text(x: double_cols ? x * 2 : x, y: y, text: ch, style: Style.new(bg: color))
      screen.text(x: x * 2 + 1, y: y, text: ch, style: Style.new(bg: color)) if double_cols
    end
  end
end

screen = Screen.new
screen.clear
draw(image: 'probes/sample.png', screen: screen)

# image = ChunkyPNG::Image.from_file('probes/sample.png')
# p ChunkyPNG::Color.rgb(image[0, 0])
# p [image.height-1, screen.height-1].min, [image.width, screen.width].min, (0..10).to_a

# screen.start

# # Creating an image from scratch, save as an interlaced PNG
# png = ChunkyPNG::Image.new(16, 16, ChunkyPNG::Color::TRANSPARENT)
# png[1,1] = ChunkyPNG::Color.rgba(10, 20, 30, 128)
# png[2,1] = ChunkyPNG::Color('black @ 0.5')
# png.save('filename.png', :interlace => true)

# Compose images using alpha blending.

# p avatar.width
# p  ChunkyPNG::Color.r(avatar[0, 0]), ChunkyPNG::Color.g(avatar[0, 0]), ChunkyPNG::Color.b(avatar[0, 0])
# badge  = ChunkyPNG::Image.from_file('no_ie_badge.png')
# avatar.compose!(badge, 10, 10)
# avatar.save('composited.png', :fast_rgba) # Force the fast saving routine.
