require_relative 'element'
require_relative 'renderer'
require_relative 'input'
require_relative 'event'
require_relative 'focus'
require_relative 'action'
require_relative 'util'
require_relative 'screen_element'
require_relative 'screen_input'
require_relative 'screen_renderer'

module TermGui
  # Main user API entry point
  # Manages instances of Input, Event, Renderer (by default disabling its buffer)
  # Is a Node so new elements can be append_child
  # Once `start`is called it will block execution and start an event loop
  # on each interval user input is read and event listeners are called
  class Screen < Node
    include ScreenElement
    include ScreenInput
    include ScreenRenderer
    attr_reader :width, :height, :input_stream, :output_stream, :renderer, :input, :event, :focus, :action
    attr_accessor :silent

    def initialize(
      children: [], text: '', attributes: {}, exit_keys: %w[q C-c], no_exit_keys: false,
      width: nil, height: nil, silent: false
    )
      super(name: 'screen', children: children, text: text, attributes: attributes, parent: nil)
      install(%i[destroy after_destroy start after_start])
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
      @action = ActionManager.new(focus: @focus, event: @event)
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
        cursor_hide # TODO: move this to a CursorManager :start listener
        render
      end
      emit :after_start
      yield if block_given?
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
      s
    end

    def alert
      puts "\a"
    end
  end
end
Screen = TermGui::Screen
