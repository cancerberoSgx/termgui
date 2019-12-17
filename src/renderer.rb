require_relative "style"
require_relative "key"

# Responsible of (TODO: we should split Renderer into several delegate classes
#  * build charsequences to render text on a position. these are directly write to $stdout by screen
#  * maintain bitmap-like buffer of current screen state
#  * manages current applied style
class Renderer
  attr :width, :height, :buffer, :style

  def initialize(width = 80, height = 20)
    @width = width
    @height = height
    @buffer = (0...@height).to_a.map {
      (0...@width).to_a.map {
        Pixel.new Pixel.EMPTY_CH, Style.new
      }
    }
    @style = Style.new
  end

  # all writing must be done using me
  def write(x, y, ch)
    if y < @buffer.length && y >= 0
      (x...[x + ch.length, @width].min).to_a.each { |i|
        @buffer[y][i].ch = ch[i - x]
      }
      "#{move x, y}#{ch}"
    else
      ""
    end
  end

  # def writeStyle
  #   @style.print
  # end

  # prints current buffer as string
  def print
    s = ""
    @buffer.each_index { |y|
      @buffer[y].each { |p|
        s = s + p.ch
      }
      s = s + '\n'
    }
    s
  end

  def move(x, y)
    "#{CSI}#{y};#{x}H"
  end

  def rect(x: 0, y: 0, width: 5, height: 3, ch: Pixel.EMPTY_CH)
    s = ""
    height.times { |y_|
      s += "#{write(x, y + y_, ch * width)}"
    }
    s
  end

  def save_cursor
    "#{CSI}s"
  end

  def restore_cursor
    "#{CSI}u"
  end

  def clear
    @style = Style.new
    @buffer.each_index { |y|
      @buffer[y].each { |p|
        p.ch = Pixel.EMPTY_CH
        p.style.reset
      }
    }
    "#{CSI}0m#{CSI}2J"
  end

  def style=(style)
    @style = style
  end

  def style_assign(style)
    @style.assign(style)
  end
end

class Pixel
  attr :ch, :style

  def self.EMPTY_CH
    " "
  end

  def initialize(ch = Pixel.EMPTY_CH, style = Style.new)
    @ch = ch
    @style = style
  end

  def ch=(ch)
    @ch = ch
  end

  def style=(style)
    @style = style
  end
end
