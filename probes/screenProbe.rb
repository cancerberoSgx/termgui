require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/style'
require_relative '../src/color'

N = 2
s = Screen.new
s.event.add_key_listener('q', proc { |_e| s.destroy })
draw = proc do |_e|
  s.clear
  s.style = Style.new bg: random_color, fg: random_color
  s.rect x: rand(s.width / N), y: rand(s.height / N), width: rand(s.width / N) + 1, height: rand(s.height / N) + 1, ch: random_char
end
s.event.add_key_listener('s', draw)
print "press q to exit and 's' to render"
s.start
