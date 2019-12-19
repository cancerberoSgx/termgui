require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/element'
require_relative '../src/style'
require_relative '../src/color'

screen = Screen.new
screen.input.install_exit_keys
e = Element.new x: 0.15, y: 0.2, width: 0.3, height: 0.5, ch: ' ', text: 'HELLO'
e.padding = Offset.new(top: 0.5, left: 0.4)
e.style = { bg: 'blue', fg: 'yellow'}
# e.style, padding: Offset.new(top: 1, left: 2)
e.style.border = Border.new(style: :double)
screen.append_child(e)

e2 = Element.new x: 0.65, y: 0.3, width: 0.2, height: 0.7, ch: '·', text: 'Lorem ipsum\nfoo bar lorem\nhello world.'
e2.padding = Offset.new(top:0.2, left: 0.15)
e2.style = { bg: 'bright_black', fg: 'bright_red'}
e2.style.border = Border.new(style: :bold)
screen.append_child(e2)

screen.render
screen.start
