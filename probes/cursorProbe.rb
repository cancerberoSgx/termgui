require_relative '../src/screen'
require_relative '../src/cursor'
require_relative '../src/log'

class TextProbe
  attr_accessor :x, :y
  def initialize(text: '', screen: nil, x: 0, y: 0)
    @x = x
    @y = y
    @lines = text.split('\n')
    @screen = screen || (throw 'screen not given')
    @cursor = Cursor.new(screen: @screen)
    @cursor.x = @x + current_line.length + 1
    @cursor.y = @y + 
  end

  def current_line
    @lines[0]
  end

  def current_line=(value)
    @lines[0] = value
  end

  def current_char
    current_line[@cursor.x - 1 ]
  end

  def enable
    disable
    @cursor.enable
    @key_listener = @screen.event.add_any_key_listener do |event|
      if ['down'].include? event.key
        @cursor.y += 1
      elsif ['up'].include? event.key
        @cursor.y = @cursor.y == 0 ? 0 : @cursor.y - 1
      elsif ['right'].include? event.key
        @cursor.x += 1
      elsif ['left'].include? event.key
        @cursor.x = @cursor.x == 0 ? 0 : @cursor.x - 1
      elsif ['tab'].include? event.key
        self.current_line = current_line + '  ' # so it matches text.length for cursor position, sorry
        @cursor.x += '  '.length
      else
        # log current_char
        self.current_line = current_line + event.raw
        @cursor.x += event.raw.length
      end
      @cursor.off = current_char || @cursor.off
      render
      @cursor.draw_on
    end
    render
  end

  def row
    @cursor.y
  end

  def col
    @cursor.x
  end

  def disable
    @cursor.disable
    @screen.event.remove_any_key_listener @key_listener if @key_listenerº
  end

  def render
    @screen.clear
    @screen.text(x: 0, y: 0, text: current_line)
  end
end

def test2
  screen = Screen.new
  screen.install_exit_keys
  text = TextProbe.new(text: 'hello world', screen: screen)
  text.enable
  screen.start
  end
test2

def test1
  screen = Screen.new
  screen.install_exit_keys
  cursor = Cursor.new(x: 2, y: 1, screen: screen)
  screen.set_timeout(1) { cursor.enable }
  screen.event.add_key_listener(%w[down enter]) do
    screen.clear
    screen.render
    cursor.y += 1
    cursor.tick
  end
  screen.event.add_key_listener(%w[up backspace]) do
    screen.clear
    screen.render
    cursor.y = cursor.y == 0 ? 0 : cursor.y - 1
    cursor.tick
  end
  screen.start
end
