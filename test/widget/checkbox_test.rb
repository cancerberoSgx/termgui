require 'test/unit'
include Test::Unit::Assertions
require_relative '../../src/screen'
require_relative '../../src/style'
require_relative '../../src/widget/checkbox'

class CheckboxTest < Test::Unit::TestCase
  def test_simple
    screen = Screen.new_for_testing(
      width: 30,
      height: 6,
      children: [
        CheckBox.new(text: 'check me', x: 2, y: 3), 
        CheckBox.new(text: 'check me 2', x: 2, y: 4)
      ]
    )
    screen.render
    assert_equal '                              \n' \
                 '                              \n' \
                 '                              \n' \
                 '  [ ] check me                \n' \
                 '  [ ] check me 2              \n' \
                 '                              \n', screen.print
    screen.event.handle_key(KeyEvent.new('space', 'space'))
    assert_equal '                              \n' \
                 '                              \n' \
                 '                              \n' \
                 '  [x] check me                \n' \
                 '  [ ] check me 2              \n' \
                 '                              \n', screen.print
    screen.event.handle_key(KeyEvent.new('enter', 'enter'))
    assert_equal '                              \n' \
                 '                              \n' \
                 '                              \n' \
                 '  [ ] check me                \n' \
                 '  [ ] check me 2              \n' \
                 '                              \n', screen.print
    screen.event.handle_key(KeyEvent.new('tab', 'tab'))
    assert_equal '                              \n' \
                 '                              \n' \
                 '                              \n' \
                 '  [ ] check me                \n' \
                 '  [ ] check me 2              \n' \
                 '                              \n', screen.print
    screen.event.handle_key(KeyEvent.new('enter', 'enter'))
    assert_equal '                              \n' \
                 '                              \n' \
                 '                              \n' \
                 '  [ ] check me                \n' \
                 '  [x] check me 2              \n' \
                 '                              \n', screen.print
    screen.event.handle_key(KeyEvent.new('tab', 'tab'))
    screen.event.handle_key(KeyEvent.new('enter', 'enter'))
    assert_equal '                              \n' \
                 '                              \n' \
                 '                              \n' \
                 '  [x] check me                \n' \
                 '  [x] check me 2              \n' \
                 '                              \n', screen.print
  end
end
