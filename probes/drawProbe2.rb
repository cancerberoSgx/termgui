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
  attr_accessor :x, :y
  def initialize(screen)
    @x = random_int(0, screen.width)
    @y = 0
    @speed_x = random_int(-2, -2)
    @speed_y = random_int(0, 2)
    @color = %w[red blue green].sample
  end

  def tick
    @speed_x = random_int(-2, 2)
    @speed_y = random_int(0, 2)
    @x += @speed_x
    @y += @speed_y
  end

  def draw(screen)
    screen.text(@x, @y, random_char, Style.new(fg: @color))
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
  interval = 0.05
  a = 100.times.map { Thing.new s }
  s.set_interval do
    s.clear
    a.each do |t|
      t.tick
      t.draw s
      if t.y > s.height
        a.delete t
      end
    end
    sleep interval
  end
  s.event.add_key_listener('p'){
    a  = a.concat(100.times.map { Thing.new s })
  }
  s.start
  # loop do
  #   t.draw s
  #   t.tick
  #   sleep 0.9
  # end
end
test2