require 'test/unit'
include Test::Unit::Assertions
require_relative '../../src/screen'
require_relative '../../src/widget/label'
require_relative '../../src/widget/row'
require_relative '../../src/widget/button'

class RowTest < Test::Unit::TestCase
  def test_simple
    screen = Screen.new(width: 20, height: 3, silent: true)
    l1 = Label.new(text: 'label1')
    l2 = Label.new(text: 'label2')
    l3 = Label.new(text: 'label3')
    Row.new(children: [l1, l2, l3], y: 1, parent: screen)
    screen.clear
    screen.render
    assert_equal '' \
      '                    \n' \
      'label1label2label3  \n' \
      '                    \n' \
      '', screen.print
  end

  def test_element_border
    screen = Screen.new(width: 40, height: 5, silent: true)
    l1 = Button.new(text: 'label1')
    l2 = Button.new(text: 'label2')
    l3 = Button.new(text: 'label3')
    Row.new(children: [l1, l2, l3], y: 2).append_to(screen)
    screen.clear
    screen.render
    assert_equal '' \
      '                                        \n' \
      '┌──────┐┌──────┐┌──────┐                \n' \
      '│label1││label2││label3│                \n' \
      '└──────┘└──────┘└──────┘                \n' \
      '                                        \n' \
      '', screen.print
  end
end
