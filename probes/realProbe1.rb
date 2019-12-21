require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/element'
require_relative '../src/style'
require_relative '../src/color'

screen = Screen.new
screen.event.add_key_listener('q', proc { screen.destroy })
e = Element.new x: 0.15, y: 0.2, width: 0.3, height: 0.5, ch: ' ', 
                text: 'Hello long long wraped text let get bigger and bigger',
                style: { bg: 'blue', fg: 'yellow', wrap: true,
                         border: Border.new(style: :double),
                         padding: Offset.new(top: 0.5, left: 0.4) }
# e.padding = Offset.new(top: 0.5, left: 0.4)
# e.style = { bg: 'blue', fg: 'yellow', wrap: true, border: Border.new(style: :double), padding: Offset.new(top: 0.5, left: 0.4)}
# e.style.wrap = true
# e.style, padding: Offset.new(top: 1, left: 2)
# e.style.border = Border.new(style: :double)
screen.append_child(e)

# screen.add_listener('destroy', proc { screen.clear; p 'bye' })
# e = Element.new x: 3, y: 2, width: 10, height: 5, ch: 'y'
# e.style = { fg: 'blue', bg: 'white' }
# f = Element.new x: 13, y: 12, width: 10, height: 5, ch: 'K'
# f.style = { fg: 'black', bg: 'red' }
# screen.render e
# screen.render f
screen.render
screen.start
