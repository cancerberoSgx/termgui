require_relative 'style'

CSI = "\e["

# Responsible of (TODO: we should split Renderer into several delegate classes
#  * build charsequences to render text on a position. these are directly write to $stdout by screen
#  * maintain bitmap-like buffer of current screen state
#  * manages current applied style
class Renderer
  attr :width, :height, :buffer, :style
  def initialize(width=80, height=20)
    @width=width
    @height=height
    # @width=@height=0
    @buffer=[@height.times{@width.times {Pixel.new ' ', {} }}]
    @style=Style.new
  end
  # all writing must be done using me
  def write(x,y,ch)
    # @buffer[y][x].ch=ch
    "#{move x, y}#{ch}"
  end
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
      # s += "#{move(x, y + y_)}#{ch * w}"
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
end
