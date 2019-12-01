require_relative 'node'

class Screen < 
  attr :width, :height, :input, :output, :buffer, :
  def initialize
    @height, @width = $stdout.winsize
    @input = $stdin
    @output = $stdout
  end

end
