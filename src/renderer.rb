CSI = "\e["

class Renderer
  def point(x,y,ch)
    "#{move x, y}#{ch}"
  end
  def move(x, y)
    "#{CSI}#{y};#{x}H"    
  end
  def rect(x, y, w, h, ch)
    s=''
    h.times { |y_|
      s += "#{move(x, y + y_)}#{ch * w}"
    }
    s
  end 
end



# if __FILE__ == $0
# r=Renderer.new
# $stdout.write r.rect(20,10,10,20, 'l')
# sleep 1
# while true do
#   $stdout.write r.point(rand(100), rand(30), ' ')
#   $stdout.write r.point(rand(100), rand(30), 'X')
#   $stdout.write r.point(rand(100), rand(30), ' ')
#   $stdout.write r.point(rand(100), rand(30), 'x')
#   $stdout.write r.point(rand(100), rand(30), ' ')
#   $stdout.write r.point(rand(100), rand(30), '*')
#   $stdout.write r.point(rand(100), rand(30), ' ')
#   # sleep 0.0001
# end
# end
