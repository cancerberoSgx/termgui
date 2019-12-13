require_relative "../src/screen"
require_relative "../src/util"
require_relative "../src/style"
require_relative "../src/color"
require "io/console"
require "io/wait"

screen = Screen.new

screen.event.addKeyListener "q", Proc.new { |e| screen.destroy }

screen.event.addKeyListener("s", Proc.new { |e|
  rect = Element.new x: 2, y: 3, width: 4, height: 3, ch: "S"
  screen.clear
  rect.render screen
  print ""
})
print '"s" to draw or "q" to exit'

# start listening for user input. This starts an user input event loop
# that ends when screen.destroy is called
screen.start
