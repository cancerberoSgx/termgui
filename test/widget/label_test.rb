require 'test/unit'
include Test::Unit::Assertions
require_relative '../../src/screen'
require_relative '../../src/style'
require_relative '../../src/widget/label'

class LabelTest < Test::Unit::TestCase
  def test_size_autoadjust
    screen = Screen.new(width: 30, height: 10)
    # screen.input.install_exit_keys
    screen.silent = true
    label = Label.new(text: 'hello world', x: 12, y: 3)
    # label.style = { bg: 'white', fg: 'black' }
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

    label2 = Label.new(
      text: 'hello longer world', x: 3, y: 5, width: 10,
      style: Style.new(bg: 'white', fg: 'blue', wrap: true, border: Border.new)
    )
    # label2.style = { bg: 'white', fg: 'blue', wrap: true }
    label2.style.wrap = true
    label2.style.border = Border.new
    screen.clear
    label2.render screen
    expected = '' \
               '                              \n' \
               '                              \n' \
               '                              \n' \
               '                              \n' \
               '  ┌──────────┐                \n' \
               '  │hello     │                \n' \
               '  │longer    │                \n' \
               '  │world     │                \n' \
               '  └──────────┘                \n' \
               '                              \n'
    assert_equal expected, screen.print

    screen.clear
    screen.append_child(label)
    screen.append_child(label2)
    label2.style.border = Border.new(style: :double)
    screen.render
    expected = '' \
               '                              \n' \
               '                              \n' \
               '           ┌───────────┐      \n' \
               '           │hello world│      \n' \
               '  ╔══════════╗─────────┘      \n' \
               '  ║hello     ║                \n' \
               '  ║longer    ║                \n' \
               '  ║world     ║                \n' \
               '  ╚══════════╝                \n' \
               '                              \n'
    assert_equal expected, screen.print
  end
end
