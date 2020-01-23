require_relative '../cursor'
require_relative '../log'
require_relative '../key'

module TermGui
  module EditorBaseHandlers
    def handle_enter
      if current_x >= current_line.length
        @lines.insert(current_y + 1, '')
      else
        line1 = current_x == 0 ? '' : current_line[0..[current_x - 1, 0].max]
        line2 = current_line[[current_x, current_line.length].min..current_line.length]
        log line1, line2
        @lines.delete_at(current_y)
        @lines.insert(current_y, line1, line2)
      end
      self.current_y += 1
      self.current_x = 0
    end

    def insert_chars(s)
      prefix = current_x < 1 ? '' : current_line[0..[current_x - 1, 0].max] || ''
      postfix = current_line[[current_x, 0].max..current_line.length] || ''
      self.current_line = prefix + s + postfix
      self.current_x += s.length
    end

    def handle_delete
      if current_x >= current_line.length && current_y >= @lines.length - 1
        @screen.alert
      else
        if current_line.length <= 1
          self.current_x = 1
          self.current_line = ''
        else
          prefix = current_line[0..[current_x - 1, 0].max]
          postfix = current_line[[current_x + 1, current_line.length].min..current_line.length] || ''
          self.current_line = prefix + postfix
          # TODO: join lines if at the end of line and there's a following
        end
      end
    end

    def cursor_down
      if self.current_y == @lines.length - 1
        if current_x > current_line.length
          @screen.alert
        else
          self.current_x = current_line.length + 1
        end
      else
        self.current_y = self.current_y == @lines.length - 1 ? current_y : current_y + 1
        self.current_x = [current_x, current_line.length + 1].min
      end
    end

    def cursor_right
      if current_x >= current_line.length
        if current_y < @lines.length - 1
          self.current_y += 1
          self.current_x = 0
        else
          @screen.alert
        end
      else
        self.current_x += 1
      end
    end

    def handle_backspace
      if current_x < 1 && current_y <= 0
        @screen.alert
      elsif current_x < 1
        old_line = (@lines.delete_at(current_y) unless @lines.empty?) || ''
        self.current_y = [current_y - 1, 0].max
        self.current_x = current_line.length
        self.current_line = current_line + old_line
      elsif current_line.length <= 1
        self.current_x = 1
        self.current_line = ''
      else
        prefix = current_line[0..[current_x - 2, 0].max]
        postfix = current_line[[current_x, current_line.length].min..current_line.length] || ''
        self.current_line = prefix + postfix
        self.current_x = [current_x - 1, 1].max
      end
    end

    def cursor_left
      if current_x < 1
        if current_y > 0
          self.current_y -= 1
          self.current_x = current_line.length
        else
          @screen.alert
        end
      else
        self.current_x -= 1
      end
    end

    def cursor_up
      if self.current_y == 0
        if self.current_x == 0
          @screen.alert
        else
          self.current_x = 0
        end
      else
        self.current_y = [current_y - 1, 0].max
        self.current_x = [current_x, current_line.length].min
      end
    end
  end
end

EditorBaseHandlers = TermGui::EditorBaseHandlers
