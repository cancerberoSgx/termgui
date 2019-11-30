class Screen
  attr :width, :height, :input, :output, :buffer
  def initialize
    @height, @width = $stdout.winsize
    @input = $stdin
    @output = $stdout
    @buffer=[@height.times{@width.times {Pixel.new}}]
  end
end
class Pixel
  attr :ch, :style
end