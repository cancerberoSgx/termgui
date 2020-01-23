require_relative '../src/screen'
require_relative '../src/cursor'
require_relative '../src/log'
require_relative '../src/editor/editor_base'

def test2
  screen = Screen.new
  screen.install_exit_keys
  text = EditorBase.new(text: 'hello world\nhow are you?', screen: screen, cursor_x: 0,cursor_y: 0)
  text.enable
  screen.start
end
test2
