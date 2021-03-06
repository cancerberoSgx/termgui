require 'test/unit'
include Test::Unit::Assertions
require_relative '../../src/screen'
require_relative '../../src/widget/label'
require_relative '../../src/widget/col'
require_relative '../../src/widget/button'

class ColTest < Test::Unit::TestCase
  def test_simple
    screen = Screen.new_for_testing(width: 15, height: 7, silent: true)
    l1 = Label.new(text: 'label1')
    l2 = Label.new(text: 'label2')
    l3 = Label.new(text: 'label3')
    c = Col.new(children: [l1, l2, l3], y: 2, x: 3)
    screen.append_child c
    screen.clear
    screen.render
    assert_equal '' \
                 '               \n' \
                 '               \n' \
                 '   label1      \n' \
                 '   label2      \n' \
                 '   label3      \n' \
                 '               \n' \
                 '               \n' \
                 '', screen.print
  end

  def test_border
    screen = Screen.new_for_testing(width: 15, height: 10, silent: true)
    l1 = Button.new(text: 'label1')
    l2 = Button.new(text: 'label2')
    l3 = Button.new(text: 'label3')
    screen.append_child Col.new(children: [l1, l2, l3], y: 1, x: 1)
    screen.clear
    screen.render
    assert_equal '' \
                 '               \n' \
                 ' ┌──────┐      \n' \
                 ' │label1│      \n' \
                 ' └──────┘      \n' \
                 ' ┌──────┐      \n' \
                 ' │label2│      \n' \
                 ' └──────┘      \n' \
                 ' ┌──────┐      \n' \
                 ' │label3│      \n' \
                 ' └──────┘      \n' \
                 '', screen.print
  end

  def test_two_labels_buttons
    screen = Screen.new_for_testing(width: 80, height: 22)
    left = Col.new(width: 0.4, height: 0.99, x: 4, y: 2, style: { bg: 'red' })
    (0..8).map { |i| left.append_child Label.new(text: "Label_#{i}") }
    right = Col.new(width: 0.6, height: 0.99, x: 0.6, y: 0.3, style: Style.new(bg: 'blue'))
    (0..4).map { |i| right.append_child Button.new(text: "Button_#{i}") }

    [left, right].each { |widget| screen.append_child widget }
    screen.clear
    screen.render
    # screen.renderer.print_dev_stdout
    assert_equal '' \
                 '                                                                                \n' \
                 '                                                                                \n' \
                 '    Label_0                                                                     \n' \
                 '    Label_1                                                                     \n' \
                 '    Label_2                                                                     \n' \
                 '    Label_3                                                                     \n' \
                 '    Label_4                                     ┌────────┐                      \n' \
                 '    Label_5                                     │Button_0│                      \n' \
                 '    Label_6                                     └────────┘                      \n' \
                 '    Label_7                                     ┌────────┐                      \n' \
                 '    Label_8                                     │Button_1│                      \n' \
                 '                                                └────────┘                      \n' \
                 '                                                ┌────────┐                      \n' \
                 '                                                │Button_2│                      \n' \
                 '                                                └────────┘                      \n' \
                 '                                                ┌────────┐                      \n' \
                 '                                                │Button_3│                      \n' \
                 '                                                └────────┘                      \n' \
                 '                                                ┌────────┐                      \n' \
                 '                                                │Button_4│                      \n' \
                 '                                                └────────┘                      \n' \
                 '                                                                                \n' \
                 '', screen.print
  end
end
