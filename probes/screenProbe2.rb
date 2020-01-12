require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/style'
require_relative '../src/color'

N = 2
s = Screen.new
s.event.add_key_listener('q', proc { |_e| s.destroy })
s.clear
s.style = { fg: 'red' }
s.rect x: 2, y: 3, width: 6, height: 5
s.start
