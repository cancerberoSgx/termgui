# frozen_string_literal: true

require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/element'
require_relative '../src/style'
require_relative '../src/color'

screen = Screen.new
screen.event.add_key_listener('q', proc { |_e| screen.destroy })
screen.add_listener('destroy', proc { screen.clear; p 'bye' })
e = Element.new x: 3, y: 2, width: 10, height: 5, ch: 'y'
e.style = { fg: 'blue', bg: 'white' }
f = Element.new x: 13, y: 12, width: 10, height: 5, ch: 'K'
f.style = { fg: 'black', bg: 'red' }
screen.render e
screen.render f

screen.start
