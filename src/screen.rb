require_relative "node"
require_relative "renderer"
require_relative "input"
require_relative "event"

# main user API entry point
# manages instances of Input, Event, Renderer
class Screen < Document
  attr :width, :height, :inputStream, :outputStream, :renderer, :input, :event

  def initialize(width: $stdout.winsize[1], height: $stdout.winsize[0])
    super name: "screen"
    # @height, @width = $stdout.winsize
    @width = width 
    @height = height  
    @inputStream = $stdin
    @outputStream = $stdout
    @renderer = Renderer.new(@width, @height)
    @input = Input.new
    @event = EventManager.new @input
  end

  # start listening for user input. This starts an user input event loop
  # that ends when screen.destroy is called
  def start
    @input.start
  end

  def destroy
    @input.stop
  end

  def write(s)
    @outputStream.write s
  end

  def rect(x: 0, y: 0, width: 5, height: 3, ch: Pixel.EMPTY_CH)
    write @renderer.rect x: x, y: y, width: width, height: height, ch: ch
  end

  def clear
    @renderer.style = Style.new
    write @renderer.style.print
    write @renderer.clear
  end

  def style=(style)
    if !@renderer.style.equals style
      @renderer.style = style
      write @renderer.style.print
    end
  end

  def render(element)
    element.render self
  end
end
