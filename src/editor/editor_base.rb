require_relative '../cursor'
require_relative '../log'
require_relative '../key'
require_relative 'editor_base_handlers'

# See TODO.md section Editor for status and TODOs
module TermGui
  class EditorBase
    include EditorBaseHandlers

    attr_accessor :x, :y

    def initialize(text: '', screen: nil, x: 0, y: 0, cursor_x: nil, cursor_y: nil)
      @x = x
      @y = y
      @screen = screen || (throw 'screen not given')
      @cursor = Cursor.new(screen: @screen)
      self.text = text
      @cursor.y = @y + cursor_y if cursor_y
      @cursor.x = @x + cursor_x if cursor_x
    end

    def cursor_x
      @cursor.x - @x
    end

    def cursor_y
      @cursor.y - @y
    end

    def text=(text)
      @lines = text.split('\n')
      @cursor.y = @y + @lines.length - 1
      @cursor.x = @x + current_line.length
    end

    def text
      @lines.join('\n')
    end

    def enable(and_render = true)
      disable
      @cursor.enable
      @key_listener = @screen.event.add_any_key_listener do |event|
        handle_key event
      end
      render if and_render
    end

    def disable
      @cursor.disable
      @screen.event.remove_any_key_listener @key_listener if @key_listener
      @key_listener = nil
    end

    def enabled
      @cursor.enabled
    end

    def render
      @screen.clear
      @lines.each_with_index do |line, i|
        @screen.text(x: @x, y: @y + i, text: line)
      end
    end

    # public so keys can be programmatically simlated - useful for tests instead of calling screen.event.handle_keythat emits globally.
    def handle_key(event)
      if !enabled
        return
      elsif ['down'].include? event.key
        cursor_down
      elsif ['up'].include? event.key
        cursor_up
      elsif ['right'].include? event.key
        cursor_right
      elsif ['left'].include? event.key
        cursor_left
      elsif ['enter'].include? event.key
        handle_enter
      elsif ['tab'].include? event.key
        insert_chars('    ') # TODO: hack - adding a tab will break since we assume all chars width is 1 (1 column per char) - it will also fail for unicode chars width>1
      elsif ['S-tab'].include? event.key
        # TODO: remove tab line prefix
      elsif event.key == 'backspace'
        handle_backspace
      elsif event.key == 'delete'
        handle_delete
      elsif alphanumeric?(event.raw) || %w[space tab].include?(event.key)
        insert_chars(event.raw)
      else
        # throw 'TODO unsupported event ' + event.to_s
      # else
      #   insert_chars(event.raw)
      end
      @cursor.off = current_char || @cursor.off
      @cursor.on = current_char || @cursor.on
      render
      @cursor.draw_on
    end

    protected

    def current_line
      @lines[current_y]
    end

    def current_line=(value)
      @lines[current_y] = value
    end

    def current_char
      current_line[current_x] || ' '
    end

    def current_x
      @cursor.x - @x
    end

    def current_x=(x)
      @cursor.x = @x + x
    end

    def current_y
      @cursor.y - @y
    end

    def current_y=(y)
      @cursor.y = @y + y
    end
  end
end

EditorBase = TermGui::EditorBase
