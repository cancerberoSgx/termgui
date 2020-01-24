require_relative 'element'
require_relative 'renderer'
require_relative 'input'
require_relative 'event'
require_relative 'focus'
require_relative 'action'
require_relative 'util'
require_relative 'screen_element'

module TermGui
  # Main user API entry point
  # Manages instances of Input, Event, Renderer
  # Is a Node so new elements can be append_child
  # Once `start`is called it will block execution and start an event loop
  # on each interval user input is read and event listeners are called
  class Screen < Node
    include ScreenElement
    attr_reader :width, :height, :input_stream, :output_stream, :renderer, :input, :event, :focus, :action
    attr_accessor :silent, :exit_keys

    def initialize(
      children: [], text: '', attributes: {}, exit_keys: %w[q C-c], no_exit_keys: false,
      width: nil, height: nil, silent: false
    )
      super(name: 'screen', children: children, text: text, attributes: attributes, parent: nil)
      @width = width == nil ? terminal_width : width
      @height = height == nil ? terminal_height : height
      @input_stream = $stdin
      @silent = silent
      @exit_keys = exit_keys
      @output_stream = $stdout
      @renderer = Renderer.new(@width, @height)
      @input = Input.new
      @event = EventManager.new @input
      @focus = FocusManager.new(root: self, event: @event)
      # //TODO: move this to Element or to FocusManager- since are elements responsibility to render when focused if they need to
      @focus.on(:focus) do |event|
        event[:focused]&.render self
        event[:previous]&.render self
      end
      @action = ActionManager.new(focus: @focus, event: @event)
      install(%i[destroy after_destroy start])
      @renderer.no_buffer = true
      install_exit_keys unless no_exit_keys
    end

    def self.new_for_testing(**args)
      instance = new(args.merge(no_exit_keys: true, silent: true))
      instance.renderer.no_buffer = false
      instance
    end

    def terminal_width
      $stdout.winsize[1]
    rescue StandardError
      80
    end

    def terminal_height
      $stdout.winsize[0]
    rescue StandardError
      24
    end

    # start listening for user input. This starts an user input event loop
    # that ends when screen.destroy is called
    def start(clean: false)
      emit :start
      unless clean
        clear
        query_by_attribute('focusable', true).length.times { @focus.focus_next } # TODO: Hack. Move to FocusManger :start listener
        cursor_hide # TODO: move this to a CursorManager :start listener
        render
      end
      @input.start
    end

    def destroy
      emit :destroy
      @input.stop
      cursor_show # TODO: move this to a CursorManager :destroy listener
      emit :after_destroy
    end

    # writes directly to @output_stream. Shouldn't be used directly since these changes won't be tracked by the buffer.
    def write(s)
      @output_stream.write s unless @silent
    end

    # renders given text at given position
    def text(x: nil, y: nil, text: ' ', style: nil)
      write @renderer.write(x, y, text, style)
    end

    def rect(x: 0, y: 0, width: 5, height: 3, ch: Pixel.EMPTY_CH, style: nil)
      # ch = style == nil ? ch : style.print(ch) # TODO: performance!!!
      renderer.style = style if style
      write @renderer.rect x: x, y: y, width: width, height: height, ch: ch
    end

    def clear
      @renderer.style = Style.new
      write @renderer.style.print
      write @renderer.clear
    end

    def style=(style)
      @renderer.style = style
      write @renderer.style.print
    end

    # complies with Element#render and also is capable of rendering given elements
    def render(element = nil)
      if element == self || element.nil?
        children.each { |child| child.render self }
      elsif !element.nil?
        element.render self
      end
    end

    def alert
      puts "\a"
    end

    def box(x, y, width, height, border_style = :classic, style = nil)
      self.style = style if style
      box = draw_box(width: width, height: height, style: border_style)
      box.each_with_index do |line, index|
        text(x: x, y: y + index, text: line)
      end
    end

    def print
      @renderer.print
    end

    # Analog to HTML DOM / Node.js setTimeout() using input event loop
    # @param {Number} seconds
    def set_timeout(seconds = @input.interval, listener = nil, &block)
      the_listener = listener == nil ? block : listener
      throw 'No listener provided' if the_listener == nil
      @input.set_timeout(seconds, the_listener)
    end

    def clear_timeout(listener)
      @input.clear_timeout(listener)
    end

    # Analog to HTML DOM / Node.js setInterval() using input event loop
    # @param {Number} seconds
    def set_interval(seconds = @input.interval, listener = nil, &block)
      the_listener = listener == nil ? block : listener
      throw 'No listener provided' if the_listener == nil
      @input.set_interval(seconds, the_listener)
    end

    def clear_interval(listener)
      @input.clear_interval(listener)
    end

    def cursor_move(x, y)
      write @renderer.move(x, y)
    end

    def cursor_show
      write @renderer.cursor_show
    end

    def cursor_hide
      write @renderer.cursor_hide
    end

    def install_exit_keys
      return if @exit_keys_listener

      @exit_keys_listener = @input.subscribe('key') do |e|
        destroy if @exit_keys.include?(e.key)
      end
    end

    def uninstall_exit_keys
      return unless @exit_keys_listener

      @input.off('key', @exit_keys_listener)
      @exit_keys_listener = nil
    end

    # def cursor_style(style)
    #   if style == 'hidden'
    #     write @renderer.cursor_hide
    #   elsif style == 'show'
    #     write @renderer.cursor_show
    #   end
    # end
  end
end
Screen = TermGui::Screen
