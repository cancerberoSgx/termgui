require_relative "../src/screen"
require_relative "../src/util"
require_relative "../src/element"
require_relative "../src/style"
require_relative "../src/color"

screen = Screen.new
screen.event.addKeyListener( "q", Proc.new { |e| screen.destroy })
screen.add_listener('destroy', Proc.new {screen.clear; p 'bye'})
e = Element.new x: 0.1, y: 0.2, width: 0.3, height: 0.5, ch: "y"
screen.append_child(e)
screen.render
screen.start
