
require_relative 'node'
require_relative 'renderer'
require_relative 'input'
require_relative 'event'
require_relative 'focus'
require_relative 'util'

# Main user API entry point
# Manages instances of Input, Event, Renderer
# Is a Node so new elements can be append_child
# Once `start`is called it will block execution and start an event loop
# on each interval user input is read and event listeners are called
class Screen < Node
  attr_reader :width, :height, :input_stream, :output_stream, :renderer, :input, :event, :focus

  def initialize(children: [], text: '', attributes: {},
                 width: $stdout.winsize[1], height: $stdout.winsize[0])
    super(name: 'screen', children: children, text: text, attributes: attributes, parent: nil)
    @width = width
    @height = height
    @input_stream = $stdin
    @output_stream = $stdout
    @renderer = Renderer.new(@width, @height)
    @input = Input.new
    @event = EventManager.new @input
    @focus = FocusManager.new(root: self, input: @input)
    on(:destroy)
  end

  # start listening for user input. This starts an user input event loop
  # that ends when screen.destroy is called
  def start
    @input.start
  end

  def destroy
    p 'destroy'
    emit :destroy
    @input.stop
  end

  # writes directly to @output_stream. Shouldn't be used directly since these changes won't be tracked by the buffer.
  def write(s)
    @output_stream.write s
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
    style = Style.from_hash style
    unless @renderer.style.equals style
      @renderer.style = style
      write @renderer.style.print
    end
  end

  # complies with Element::render and also is capable of rendering given elements
  def render(element = nil)
    if element == self || element.nil?
      children.each { |child| child.render self }
    elsif element.render self
    end
  end

  def text(x, y, text)
    write @renderer.write(x, y, text)
  end

  def abs_x
    0
  end

  def abs_y
    0
  end

  def abs_width
    @width
  end

  def abs_height
    @height
  end

  def print
    @renderer.print
  end

  def set_timeout(seconds, block)
    @input.set_timeout(seconds, block)
  end

  def clear_timeout(_listener)
    @input.clear_timeout(block)
  end

  # TODO: seconds not implemented - block will be called on each input interval
  def set_interval(seconds = @interval, block)
    @input.set_interval(seconds, block)
  end

  def clear_interval(_listener)
    @input.clear_interval(block)
  end
end
