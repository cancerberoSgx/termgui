require 'chunky_png'
require 'fileutils'
require_relative 'util/imagemagick'
# small facade for image decoding and processing
# Right now only supports reading png thanks to chunky_png
module TermGui
  class Image
    attr_reader :path

    def initialize(image = nil, path = image.is_a?(String) ? image : 'unknown.png')
      if image.is_a?(String)
        if File.extname(image).capitalize != '.png'
          if !image_magick_available
            throw 'Cannot create image from non PNG file without imagemagick available'
          else
            image = convert(image)
          end
        end
      end
      @image = image.is_a?(String) ? ChunkyPNG::Image.from_file(image) : image
      @path = path
    end

    def rgb(x = 0, y = 0, transparent_color = nil)
      p = @image[x, y]
      if transparent_color
        bg = ChunkyPNG::Color.rgb(transparent_color[0], transparent_color[1], transparent_color[2])
        p = ChunkyPNG::Color. interpolate_quick(p, bg,  ChunkyPNG::Color.a(p))
      end
      [ChunkyPNG::Color.r(p), ChunkyPNG::Color.g(p), ChunkyPNG::Color.b(p)]
    end

    def rgba(x = 0, y = 0)
      p = @image[x, y]
      [ChunkyPNG::Color.r(p), ChunkyPNG::Color.g(p), ChunkyPNG::Color.b(p), ChunkyPNG::Color.a(p)]
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

    def crop(x: 0, y: 0, width: @image.width, height: @image.height)
      Image.new(@image.crop(x, y, width, height), path)
    end
  end
end
