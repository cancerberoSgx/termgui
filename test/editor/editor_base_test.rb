require 'test/unit'
include Test::Unit::Assertions
require_relative '../../src/editor/editor_base'
require_relative '../../src/log'
require_relative '../../src/screen'
require_relative '../../src/event'

class EditorBaseTest < Test::Unit::TestCase
  def test_arrows_enter_cursor_backspace
    screen = Screen.new(width: 24, height: 6)
    screen.install_exit_keys
    screen.silent = true
    ed = EditorBase.new(text: 'hello world\nhow are you?', screen: screen, cursor_x: 0, cursor_y: 0)
    ed.enable
    screen.set_timeout(0.1) do
      assert_equal 'hello world\nhow are you?', ed.text
      assert_equal ['hello world', 'how are you?'], ed.lines
      assert_equal 0, ed.cursor_x
      assert_equal 0, ed.cursor_y
      ed.render
      assert_equal(
        'hello world             \n' \
        'how are you?            \n' \
        '                        \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print)
      assert_equal([0, 0], [ed.cursor_x, ed.cursor_y])
      screen.event.handle_key(KeyEvent.new('right'))
      assert_equal([1, 0], [ed.cursor_x, ed.cursor_y])
      screen.event.handle_key(KeyEvent.new('enter'))
      ed.render
      assert_equal( 
        'h                       \n' \
        'ello world              \n' \
        'how are you?            \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print)
      screen.event.handle_key(KeyEvent.new('backspace'))
      ed.render
      assert_equal(
        'hello world             \n' \
        'how are you?            \n' \
        '                        \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print)

      screen.destroy
    end
    screen.start
  end
end
