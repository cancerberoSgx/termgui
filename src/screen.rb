require_relative "node"
require_relative "renderer"
require_relative "input"
require_relative "event"

class Screen < Node
  attr :width, :height, :inputStream, :outputStream, :renderer, :input, :event

  def initialize(width = $stdout.winsize[1], height = $stdout.winsize[0])
    super "screen"
    @height, @width = $stdout.winsize
    @width = width || @width
    @height = height || @height
    @inputStream = $stdin
    @outputStream = $stdout
    @renderer = Renderer.new(@width, @height)
    @input = Input.new
    @event = EventManager.new @input
  end

  def start
    @input.start
  end

  def destroy
    @input.stop
  end

  def write(s)
    @outputStream.write s
  end

  def rect(x, y, w, h, ch)
    write @renderer.rect x, y, w, h, ch
  end

  def clear
    write @renderer.clear
  end
end
