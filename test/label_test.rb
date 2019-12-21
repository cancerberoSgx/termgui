require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/screen'
require_relative '../src/style'
require_relative '../src/widget/label'

class LabelTest < Test::Unit::TestCase
  def test_size_autoadjust
    screen = Screen.new(width: 30, height: 10)
    # screen.input.install_exit_keys
    screen.silent = true
    label = Label.new(text: 'hello world', x: 12, y: 3)
    label.style = { bg: 'white', fg: 'black' }
    label.style.border = Border.new
    screen.clear
    label.render screen
    # screen.print.split('\\n').each { |line| puts "'#{line}\\n' + " }
    expected = '                              \n' \
               '                              \n' \
               '           ┌───────────┐      \n' \
               '           │hello world│      \n' \
               '           └───────────┘      \n' \
               '                              \n' \
               '                              \n' \
               '                              \n' \
               '                              \n' \
               '                              \n'
               
    assert_equal expected, screen.print
  end
end
