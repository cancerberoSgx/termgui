require_relative 'style'
require_relative 'key'
require_relative 'renderer_print'
require_relative 'renderer_cursor'
require_relative 'renderer_image'

module TermGui
  # Responsible of (TODO: we should split Renderer into several delegate classes
  #  * build charsequences to render text on a position. these are directly write to $stdout by screen
  #  * maintain bitmap-like buffer of current screen state
  #  * manages current applied style
  # TODO: add line, empty-rect and more drawing primitives
  class Renderer
    include RendererPrint
    include RendererCursor
    include RendererImage

    attr_reader :width, :height, :buffer, :style
    attr_writer :style, :no_buffer

    def initialize(width = 80, height = 20, no_buffer = false)
      @width = width
      @height = height
      @style = Style.new
      @no_buffer = no_buffer
      self.fast_colouring = true
      unless no_buffer
        @buffer = (0...@height).to_a.map do
          (0...@width).to_a.map do
            Pixel.new
          end
        end
      end
    end

    # all writing must be done using me
    def write(x, y, s, style = nil)
      if y < @height && y >= 0
        # TODO: x could be negative now, trunc ch to respect screen bounds - if not negative values are printed at the right
        if x < 0
          s = s[[x * -1, s.length].min..s.length]
          x = 0
        end
        unless @no_buffer
          (x...[x + s.length, @width].min).to_a.each do |i|
            @buffer[y][i].ch = s[i - x]
            @buffer[y][i].style = (style || @style).clone
          end
        end
        # apply the style after writing to the buffer so it don't contains escape secuences just the chars
        s = style == nil ? s : style.print(s)
        "#{move x, y + 1}#{s}" # TODO: investigate why y + 1
      else
        ''
      end
    end

    def move(x, y)
      Renderer.move x, y
    end

    def self.move(x, y)
      "#{CSI}#{y};#{x}H"
    end

    def text(x: 0, y: 0, text: ' ', style: nil)
      write(x, y, text, style)
    end

    def rect(x: 0, y: 0, width: 5, height: 3, ch: Pixel.EMPTY_CH, style: nil)
      s = []
      ch = Pixel.EMPTY_CH if ch == nil
      height.times do |y_|
        s .push write(x, y + y_, ch * width, style).to_s
      end
      s.join('')
    end

    def clear
      @style = Style.new
      unless @no_buffer
        @buffer.each_index do |y|
          @buffer[y].each do |p|
            p.ch = Pixel.EMPTY_CH
            p.style.reset
          end
        end
      end
      "#{CSI}0m#{CSI}2J"
    end

    def style_assign(style)
      @style.assign(style)
    end

    def fast_colouring=(value)
      Style.fast_colouring(value)
    end
  end

  # Represents a pixel in renderer's buffer
  class Pixel
    attr_accessor :ch, :style

    def self.EMPTY_CH
      ' '
    end

    def initialize(ch = Pixel.EMPTY_CH, style = Style.new)
      @ch = ch
      @style = style
    end
  end
end

Renderer = TermGui::Renderer
Pixel = TermGui::Pixel
