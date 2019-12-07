require_relative "../src/screen"
require_relative "../src/util"
require_relative "../src/style"
require_relative "../src/color"
require "io/console"
require "io/wait"

s = Screen.new
s.input.defaultExitKeys
s.event.addKeyListener("s", Proc.new { |e| 
  rect=Rect.new 2,3,4,3,'S'
  rect.render s
})

s.start
