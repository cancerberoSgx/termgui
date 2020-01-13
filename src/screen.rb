require_relative 'node'
require_relative 'renderer'
require_relative 'input'
require_relative 'event'
require_relative 'focus'
require_relative 'action'
require_relative 'util'
require_relative 'color'

# Main user API entry point
# Manages instances of Input, Event, Renderer
# Is a Node so new elements can be append_child
# Once `start`is called it will block execution and start an event loop
# on each interval user input is read and event listeners are called
class Screen < Node
  attr_reader :width, :height, :input_stream, :output_stream, :renderer, :input, :event, :focus, :action
  attr_accessor :silent

  def initialize(children: [], text: '', attributes: {},
                 width: nil, height: nil)
    super(name: 'screen', children: children, text: text, attributes: attributes, parent: nil)
    @width = width == nil ? terminal_width : width
    @height = height == nil ? terminal_height : height
    @input_stream = $stdin
    @output_stream = $stdout
    @renderer = Renderer.new(@width, @height)
    @input = Input.new
    @event = EventManager.new @input
    @focus = FocusManager.new(root: self, input: @input)
    @focus.on(:focus) do |event|
      event[:focused]&.render self
      event[:previous]&.render self
    end
    @action = ActionManager.new @focus, @input
    @silent = false
    install(:destroy)
    install(:start)
  end

  def terminal_width
    $stdout.winsize[1]
  rescue StandardError
    80
  end

  def terminal_height
    $stdout.winsize[0]
  rescue StandardError
    36
  end

  # start listening for user input. This starts an user input event loop
  # that ends when screen.destroy is called
  def start(clean: false)
    emit :start
    unless clean
      clear
      # TODO: Hack. Move to FocusManger :start listener
      query_by_attribute('focusable', true).length.times { @focus.focus_next }
      # TODO: this shouldn't be neccesary, when Element#final_style is implemented
      @focus.subscribe(:focus) do |e|
        e[:focused]&.style&.bg= 'white'
        e[:focused]&.style&.fg= 'blue'
        e[:previous]&.style&.bg= 'black'
        e[:previous]&.style&.fg= 'magenta'
        render e[:focused]
        render e[:previous]
      end
      cursor_hide # TODO: move this to a CursorManager :start listener
      render
    end
    @input.start
  end

  def destroy
    emit :destroy
    @input.stop
    cursor_show # TODO: move this to a CursorManager :destroy listener
  end

  # writes directly to @output_stream. Shouldn't be used directly since these changes won't be tracked by the buffer.
  def write(s)
    @output_stream.write s unless @silent
  end

  # renders given text at given position
  def text(x, y, text)
    write @renderer.write(x, y, text)
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
    # style = Style.from_hash style
    # unless @renderer.style.equals style
    @renderer.style = style
    write @renderer.style.print
    # end
  end

  # complies with Element#render and also is capable of rendering given elements
  def render(element = nil)
    if element == self || element.nil?
      children.each { |child| child.render self }
    elsif !element.nil?
      element.render self
    end
  end

  def box(x, y, width, height, border_style = :classic, style = nil)
    self.style = style if style
    box = draw_box(width: width, height: height, style: border_style)
    box.each_with_index do |line, index|
      text x, y + index, line
    end
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

  def set_timeout(seconds, listener = nil, &block)
    the_listener = listener == nil ? block : listener
    throw 'No listener provided' if the_listener == nil
    @input.set_timeout(seconds, the_listener)
  end

  def clear_timeout(listener)
    @input.clear_timeout(listener)
  end

  # TODO: seconds not implemented - block will be called on each input interval
  def set_interval(seconds = @interval, block)
    @input.set_interval(seconds, block)
  end

  def clear_interval(_listener)
    @input.clear_interval(block)
  end

  def install_exit_keys
    @input.install_exit_keys
  end

  def cursor_move(x, y)
    write @renderer.move(x, y)
  end

  def cursor_show(style = nil)
    if style == nil
      write @renderer.cursor_show
    elsif style == 'blink'
      write color(ATTRIBUTES[:blink])
    end
  end

  def cursor_hide
    write @renderer.cursor_hide
  end

  # def cursor_style(style)
  #   if style == 'hidden'
  #     write @renderer.cursor_hide
  #   elsif style == 'show'
  #     write @renderer.cursor_show
  #   end
  # end
end
