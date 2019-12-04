require_relative "node"
require_relative "renderer"
require_relative "input"
require_relative "event"

class Screen < Node
  attr :width, :height, :inputStream, :outputStream, :renderer, :input, :event

  def initialize(width = $stdout.winsize[0], height = $stdout.winsize[1])
    super "screen"
    @height, @width = $stdout.winsize
    @width = width || @width
    @height = height || @height
    @inputStream = $stdin
    @outputStream = $stdout
    @renderer = Renderer.new(@width, @height)
    @input = Input.new
    @event = EventManager.new @input
    # @input.subscribe('key', {|e|
    #   self.handleKey e
    # })
  end

  def start
    @input.start
  end

  def destroy
    @input.stop
  end

  # protected

  # def handleKey(e)

  # end
end
