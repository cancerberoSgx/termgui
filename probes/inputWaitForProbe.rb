require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/element'
require_relative '../src/style'
require_relative '../src/color'

screen = Screen.new
e = Element.new x: 0.15, y: 0.2, width: 0.3, height: 0.5, ch: ' ', text: 'HELLO', parent: screen

screen.set_timeout(1) do
  e.text = 'OK'
end

screen.input.wait_for(proc { e.text == 'OK' }) do |timeout|
  screen.destroy
  p timeout ? 'TIMEOUT' : 'OK'
end

screen.render
screen.start
