require 'test/unit'
include Test::Unit::Assertions
require_relative '../../src/screen'
require_relative '../../src/widget/label'
require_relative '../../src/widget/row'

class RowTest < Test::Unit::TestCase
  def test_simple
    screen = Screen.new(width: 20, height: 3)
    screen.install_exit_keys
    screen.silent = true
    l1 = Label.new(text: 'label1')
    l2 = Label.new(text: 'label2')
    l3 = Label.new(text: 'label3')
    r = Row.new(children: [l1, l2, l3], y: 1)
    screen.append_child r
    screen.clear
    screen.render
    assert_equal '' \
                 '                    \n' \
                 'label1label2label3  \n' \
                 '                    \n' \
                 '', screen.print
  end
end
