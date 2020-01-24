require_relative '../src/screen'

s = Screen.new

a = s.append_child Button.new(text: 'hello')
# s.action.
# draw = proc do |_e|
#   s.clear
#   s.style = Style.new bg: random_color, fg: random_color
#   s.rect x: rand(s.width / N), y: rand(s.height / N), width: rand(s.width / N) + 1, height: rand(s.height / N) + 1, ch: random_char
# end
# s.event.add_key_listener('s', draw)
# print "press q to exit and 's' to render"
# s.start
