require_relative 'style'
require_relative 'key'
# CSI = "\e["

# Responsible of (TODO: we should split Renderer into several delegate classes
#  * build charsequences to render text on a position. these are directly write to $stdout by screen
#  * maintain bitmap-like buffer of current screen state
#  * manages current applied style
class Renderer
  attr :width, :height, :buffer, :style
  def initialize(width=80, height=20)
    @width=width
    @height=height
    @buffer = (0...@height).to_a.map {
      (0...@width).to_a.map {
        Pixel.new '-', {}
      }
    }
    @style=Style.new
  end
  # all writing must be done using me
  def write(x,y,ch)
    (x...[x+ch.length, @width].min).to_a.each{|i|
      @buffer[y][i].ch=ch[i-x]
    }
    "#{move x, y}#{ch}"
  end
  # prints current buffer as string
  def print
    s=''
    @buffer.each_index{|y|
      @buffer[y].each{|p|
        s=s+p.ch
      }
      s=s+'\n'
    }
    s
  end
  def move(x, y)
    "#{CSI}#{y};#{x}H"    
  end
  def rect(x, y, w, h, ch)
    s=''
    h.times { |y_|
      s += "#{write(x, y + y_, ch * w)}"
    }
    s
  end 
end

class Pixel
  attr :ch, :style
  def initialize(ch, style)
    @ch=ch
    @style=style
  end
  def ch=(ch)
    @ch = ch
  end 
  def style=(style)
  @style = style
end
end
