
require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/element'
require_relative '../src/style'
require_relative '../src/color'

screen = Screen.new

screen.event.add_key_listener('q', proc { |_e| screen.destroy })

e = Element.new
e.style = {
  fg: 'black', bg: white
}
print e.style

screen.event.add_key_listener('s', proc do |_e|
  rect = Element.new(x: 2, y: 3, width: 4, height: 3, ch: 'S', style: Style.new(bg: 'green'))
  screen.clear
  rect.render screen
  print ''
end)
print '"s" to draw or "q" to exit'

# start listening for user input. This starts an user input event loop
# that ends when screen.destroy is called
screen.start
