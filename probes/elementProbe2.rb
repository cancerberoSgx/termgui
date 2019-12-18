require_relative "../src/screen"
require_relative "../src/util"
require_relative "../src/element"
require_relative "../src/style"
require_relative "../src/color"
require "io/console"
require "io/wait"

screen = Screen.new
screen.event.addKeyListener "q", Proc.new { |e| screen.destroy }
screen.addListener('destroy', Proc.new {screen.clear; p 'bye'})
e = Element.new x: 3, y: 2, width: 10, height: 5, ch: "y"
screen.style = {  fg: "black", bg: "white"}
screen.render e

screen.start
