require_relative '../cursor'
require_relative '../log'
require_relative '../key'

# class EnterHandler
#   def handle(event)
#   end
# end


module TermGui
  class EditorBase
    attr_accessor :x, :y

    def initialize(text: '', screen: nil, x: 0, y: 0, cursor_x: nil, cursor_y: nil)
      @x = x
      @y = y
      @screen = screen || (throw 'screen not given')
      @cursor = Cursor.new(screen: @screen)
      self.text = text
      @cursor.y = @y + cursor_y if cursor_y
      @cursor.x = @x + cursor_x + 1 if cursor_x 
    end

    def cursor_x
      @cursor.x - @x - 1
    end

    def cursor_y
      @cursor.y - @y
    end

    def text=(text)
      @lines = text.split('\n')
      @cursor.y = @y + @lines.length - 1
      @cursor.x = @x + current_line.length + 1
    end

    def text
      @lines.join('\n')
    end

    def lines
      @lines.map{|s|s+''}
    end

    def current_line
      @lines[@cursor.y]
    end

    # @cursor.y defines de current line
    def current_line=(value)
      @lines[@cursor.y] = value
    end

    def current_char
      current_line[@cursor.x - 1] || ' '
    end

    def enable
      disable
      @cursor.enable
      @key_listener = @screen.event.add_any_key_listener do |event|
        handle_key event
      end
      render
    end

    def disable
      @cursor.disable
      @screen.event.remove_any_key_listener @key_listener if @key_listener
    end

    def render
      @screen.clear
      @lines.each_with_index do |line, i|
        @screen.text(x: @x, y: @y + i, text: line)
      end
    end

    def handle_key(event)
      if ['down'].include? event.key
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
        insert_chars('    ')

      elsif ['S-tab'].include? event.key
        # cursor_left(2)
        # cursor_leftC

      elsif event.key == 'backspace'
        handle_backspace

      elsif event.key == 'delete'
        handle_delete

      elsif alphanumeric?(event.raw) || ['space', 'tab'].include?(event.key )
        insert_chars(event.raw)

      else
        throw 'TODO unsupported event ' + event.to_s
      end

      @cursor.off = current_char || @cursor.off # so it renders the char and not empty space while blinking
      render
      @cursor.draw_on
    end

    def handle_enter
      if @cursor.x >= current_line.length
        @lines.insert(@cursor.y + 1, '')
      else
        line1 = current_line[0..@cursor.x - 2]
        line2 = current_line[@cursor.x - 1..current_line.length]
        @lines.delete_at(@cursor.y)
        @lines.insert(@cursor.y, line1, line2)
      end
      @cursor.y += 1
      @cursor.x = @x + 1
    end

    def insert_chars(s)
      prefix = @cursor.x <= 1 ? '' : current_line[0.. [@cursor.x-2, 0].max] || ''
      postfix = current_line[[@cursor.x - 1, 0].max..current_line.length] || ''
      self.current_line = prefix + s + postfix
      @cursor.x += s.length
    end

    def handle_delete
      if @cursor.x >= current_line.length && @cursor.y >= @lines.length - 1
        @screen.alert
      else
        if current_line.length <= 1
          @cursor.x = 1
          self.current_line = ''
        else
          prefix = current_line[0..[@cursor.x - 1, 0].max]
          postfix = current_line[[@cursor.x + 1, current_line.length].min..current_line.length] || ''
          self.current_line = prefix + postfix
          # TODO: join lines if at the end of line and there's a following
        end
      end
    end

    def cursor_down
      if @cursor.y == @lines.length - 1
        if @cursor.x > current_line.length
          @screen.alert
        else
          @cursor.x = current_line.length + 1
        end
      else
        @cursor.y = @cursor.y == @lines.length - 1 ? @cursor.y : @cursor.y + 1
        @cursor.x = [@cursor.x, current_line.length+1].min
      end
    end

    def cursor_right
      if @cursor.x > current_line.length
        if @cursor.y < @lines.length - 1
          @cursor.y += 1
          @cursor.x = 1
        else
          @screen.alert
        end
      else
        @cursor.x += 1
      end
    end

    def handle_backspace
      if @cursor.x <= 1 && @cursor.y <= 0
        @screen.alert
      elsif @cursor.x <= 1
        old_line = (@lines.delete_at(@cursor.y) unless @lines.empty?) || ''
        @cursor.y = [@cursor.y - 1, 0].max
        @cursor.x = current_line.length + 1
        self.current_line = current_line + old_line
      elsif current_line.length <= 1
        @cursor.x = 1
        self.current_line = ''
      else
        prefix = current_line[0..[@cursor.x - 2, 0].max]
        postfix = current_line[[@cursor.x, current_line.length].min..current_line.length] || ''
        self.current_line = prefix + postfix
        @cursor.x = [@cursor.x - 1, 1].max
      end
    end

    def cursor_left
      if @cursor.x <= 1
        if @cursor.y > 0
          @cursor.y -= 1
          @cursor.x = (current_line.length + 1)
        else
          @screen.alert
        end
      else
        @cursor.x -= 1
      end
    end

    def cursor_up
      if @cursor.y == 0
        if @cursor.x == 1
          @screen.alert
        else
          @cursor.x = 1
        end
      else
        @cursor.y = [@cursor.y - 1, 0].max
        @cursor.x = [@cursor.x, current_line.length+1].min
      end
    end
  end
end

EditorBase = TermGui::EditorBase
