require_relative 'node'
require_relative 'renderer'
require_relative 'input'

class Screen < Node

  attr :width, :height, :inputStream, :outputStream, :renderer, :input

  def initialize(width, height)
    super 'screen'
    @height, @width = $stdout.winsize
    @width = width||@width
    @height = height||@height
    @inputStream = $stdin
    @outputStream = $stdout
    @renderer = Renderer.new(@width, @height)
    @input = Input.new
    @input.subscribe('key', {|e|
      self.handleKey e
    })
  end
  def start
    @input.start
  end
  def destroy
    @input.stop
  end

  protected
  
  def handleKey(e)

  end
end
