require_relative "../src/screen"
require_relative "../src/util"
require "io/console"
require "io/wait"

N = 2
s = Screen.new
s.event.addKeyListener("q", Proc.new { |e| s.destroy })
s.event.addKeyListener("s", Proc.new { |e|
  s.clear
  s.rect(rand(s.width / N), rand(s.height / N), rand(s.width / N) + 1, rand(s.height / N) + 1, randomChar)
})
# t = Thread.new { sleep 1; $stdin.raw do |io| io.syswrite('q') end}
# t.join
s.start
