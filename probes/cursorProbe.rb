require_relative '../src/screen'
require_relative '../src/cursor'
require_relative '../src/log'

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
test1
