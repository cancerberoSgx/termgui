# start =
require_relative '../src/screen'
require_relative '../src/style'
require_relative '../src/widget/col'
require_relative '../src/widget/row'
require_relative '../src/widget/modal'
require_relative '../src/widget/button'
require_relative '../src/widget/label'
require_relative '../src/util'

class Thing
  def initialize(screen)
    @x=random_int(0, screen.width)
    @y = 0
    @speed_x= random_int(-2, -2)
    @speed_y= random_int(0, 2)
  end
  def tick
    @speed_x = random_int(-2, 2)
    @speed_y= random_int(0, 2)
    @x += @speed_x
    @y += @speed_y
  end
  def draw(screen)
    screen.text(@x, @y, random_char)
  end
end

def test1
  s = Screen.new
  s.install_exit_keys
  t = Thing.new s
  loop do
    t.draw s
    t.tick
    sleep 0.9
  end
end

def test2
  s = Screen.new
  s.install_exit_keys
  interval = 0.2
  a = 100.times.map{Thing.new s}
  s.set_interval{
    s.clear
    a.each{|t|
    t.tick
    t.draw s
  }
  sleep interval
  }
  s.start
  # loop do
  #   t.draw s
  #   t.tick
  #   sleep 0.9
  # end
end
test2