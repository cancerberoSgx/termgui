require 'chunky_png'

# small facade for image decoding and processing
# Right now only supports reading png thanks to chunky_png
module TermGui
  class Image
    def initialize(file = nil)
      @image = ChunkyPNG::Image.from_file(file)
    end

    def pixel(x = 0, y = 0)
      p = @image[x, y]
      [ChunkyPNG::Color.r(p), ChunkyPNG::Color.g(p), ChunkyPNG::Color.b(p)]
    end

    def width
      @image.width
    end

    def height
      @image.height
    end
  end
end
