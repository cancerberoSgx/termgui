require_relative "../src/screen"
require_relative "../src/util"
require_relative "../src/style"
require_relative "../src/color"
require "io/console"
require "io/wait"

N = 2
s = Screen.new
s.event.addKeyListener("q", Proc.new { |e| s.destroy })
draw = Proc.new { |e|
  s.clear
  s.style = Style.new randomColor, randomColor
  s.rect(rand(s.width / N), rand(s.height / N), rand(s.width / N) + 1, rand(s.height / N) + 1, randomChar)
}
s.event.addKeyListener("s", draw)
print "press q to exit and 's' to render"
s.start
