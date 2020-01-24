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
    @style = Style.new(fg: %w[red blue green].sample)
  end

  def tick
    @speed_x = random_int(-2, 2)
    @speed_y = random_int(0, 2)
    @x += @speed_x
    @y += @speed_y
  end

  def draw(screen)
    screen.text(x: @x, y: @y, text: random_char, style: @style)
  end

  def erase(screen)
    screen.text(x: @x, y: @y, text: ' ', style: Style.new)
  end
end

def test1
  s = Screen.new
  t = Thing.new s
  loop do
    t.draw s
    t.tick
    sleep 0.9
  end
end

def test2
  s = Screen.new
  amount = 200
  interval = 0.05
  a = amount.times.map { Thing.new s }
  s.set_interval(interval) do
    # s.clear
    a.each do |t|
      t.erase s
      t.tick
      t.draw s
      a.delete t if t.y > s.height
    end
    # sleep interval
  end
  s.event.add_key_listener('p') do
    a = a.concat(amount.times.map { Thing.new s })
  end
  s.start
end
test2
