require 'chunky_png'

# small facade for image decoding and processing
# Right now only supports reading png thanks to chunky_png
module TermGui
  class Image
    attr_reader :path

    def initialize(image = nil, path = image.is_a?(String) ? image : 'unknown.png')
      @image = image.is_a?(String) ? ChunkyPNG::Image.from_file(image) : image
      @path = path
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

    # returns a new image which is the result of scaling this image to given dimentions
    def scale(width: @image.width, height: @image.height,
              algorithm: 'bilineal') # bilinear, nearest_neighbor
      if algorithm == 'nearest_neighbor'
        Image.new(@image.resample_nearest_neighbor(width, height), path)
      else
        Image.new(@image.resample_bilinear(width, height), path)
      end
    end
  end
end
