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
    screen.set_timeout do
      assert_equal 'hello world\nhow are you?', ed.text
      # assert_equal ['hello world', 'how are you?'], ed.lines
      assert_equal [0, 0], [ed.cursor_x, ed.cursor_y]

      screen.clear
      ed.render
      assert_equal(
        'hello world             \n' \
        'how are you?            \n' \
        '                        \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [0, 0], [ed.cursor_x, ed.cursor_y]

      screen.event.handle_key(KeyEvent.new('right'))
      assert_equal [1, 0], [ed.cursor_x, ed.cursor_y]

      screen.event.handle_key(KeyEvent.new('enter'))
      screen.clear
      ed.render
      assert_equal(
        'h                       \n' \
        'ello world              \n' \
        'how are you?            \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )

      screen.event.handle_key(KeyEvent.new('backspace'))
      screen.clear
      ed.render
      assert_equal(
        'hello world             \n' \
        'how are you?            \n' \
        '                        \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [1, 0], [ed.cursor_x, ed.cursor_y]

      6.times { screen.event.handle_key(KeyEvent.new('right')) }
      screen.event.handle_key(KeyEvent.new('left'))
      screen.event.handle_key(KeyEvent.new('down'))
      assert_equal [6, 1], [ed.cursor_x, ed.cursor_y]

      screen.event.handle_key(KeyEvent.new('enter'))
      screen.clear
      ed.render
      assert_equal(
        'hello world             \n' \
        'how ar                  \n' \
        'e you?                  \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [0, 2], [ed.cursor_x, ed.cursor_y]

      screen.event.handle_key(KeyEvent.new('backspace'))
      screen.clear
      ed.render
      assert_equal(
        'hello world             \n' \
        'how are you?            \n' \
        '                        \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [6, 1], [ed.cursor_x, ed.cursor_y]

      6.times { screen.event.handle_key(KeyEvent.new('left')) }
      assert_equal [0, 1], [ed.cursor_x, ed.cursor_y]
      screen.event.handle_key(KeyEvent.new('backspace'))
      screen.clear
      ed.render
      assert_equal(
        'hello worldhow are you? \n' \
        '                        \n' \
        '                        \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [11, 0], [ed.cursor_x, ed.cursor_y]

      3.times { screen.event.handle_key(KeyEvent.new('space')) }
      screen.clear
      ed.render
      assert_equal(
        'hello world   how are yo\n' \
        '                        \n' \
        '                        \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [14, 0], [ed.cursor_x, ed.cursor_y]

      screen.event.handle_key(KeyEvent.new('X'))
      screen.event.handle_key(KeyEvent.new('enter'))
      screen.clear
      ed.render
      assert_equal(
        'hello world   X         \n' \
        'how are you?            \n' \
        '                        \n' \
        '                        \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [0, 1], [ed.cursor_x, ed.cursor_y]
      # screen.clear
      ed.render
      # screen.renderer.print_dev_stdout

      screen.destroy
    end
    screen.start
  end

  def test_coords
    screen = Screen.new(width: 24, height: 6)
    screen.install_exit_keys
    screen.silent = true
    ed = EditorBase.new(text: 'Welcome to this\nhumble editor', screen: screen, cursor_x: 0, cursor_y: 0, x: 5, y: 2)
    ed.enable
    screen.set_timeout do
      screen.clear
      ed.render
      assert_equal(
        '                        \n' \
        '                        \n' \
        '     Welcome to this    \n' \
        '     humble editor      \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [0, 0], [ed.cursor_x, ed.cursor_y]
      screen.event.handle_key(KeyEvent.new('down'))
      assert_equal [0, 1], [ed.cursor_x, ed.cursor_y]
      screen.event.handle_key(KeyEvent.new('right'))
      assert_equal [1, 1], [ed.cursor_x, ed.cursor_y]
      screen.event.handle_key(KeyEvent.new('enter'))
      screen.clear
      ed.render
      assert_equal(
        '                        \n' \
        '                        \n' \
        '     Welcome to this    \n' \
        '     h                  \n' \
        '     umble editor       \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [0, 2], [ed.cursor_x, ed.cursor_y]

      screen.event.handle_key(KeyEvent.new('backspace'))
      assert_equal [1, 1], [ed.cursor_x, ed.cursor_y]
      screen.clear
      ed.render
      assert_equal(
        '                        \n' \
        '                        \n' \
        '     Welcome to this    \n' \
        '     humble editor      \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [1, 1], [ed.cursor_x, ed.cursor_y]

      screen.event.handle_key(KeyEvent.new('A'))
      screen.clear
      ed.render
      assert_equal(
        '                        \n' \
        '                        \n' \
        '     Welcome to this    \n' \
        '     hAumble editor     \n' \
        '                        \n' \
        '                        \n', screen.renderer.print
      )
      assert_equal [2, 1], [ed.cursor_x, ed.cursor_y]

      # screen.renderer.print_dev_stdout

      screen.destroy
    end
    screen.start
  end
end
