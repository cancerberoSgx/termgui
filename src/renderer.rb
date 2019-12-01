require_relative 'style'

CSI = "\e["

# Responsible of (TODO: we should split Renderer into several delegate classes
#  * build charsequences to render text on a position. these are directly write to $stdout by screen
#  * maintain bitmap-like buffer of current screen state
#  * manages current applied style
class Renderer
  attr :width, :height, :buffer, :style
  @width=@height=0
  @buffer=[@height.times{@width.times {Pixel.new}}]
  @style=Style.new
  def write(x,y,ch)
    "#{move x, y}#{ch}"
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
end
