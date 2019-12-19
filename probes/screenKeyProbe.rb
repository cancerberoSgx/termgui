
require_relative '../src/screen'

screen = Screen.new
screen.event.add_key_listener('C-c', proc{print 'bye'})

screen.event.add_key_listener('q', proc { |_e| screen.destroy })
screen.clear
screen.style = { fg: 'red' }
screen.rect x: 2, y: 3, width: 6, height: 5
screen.start
