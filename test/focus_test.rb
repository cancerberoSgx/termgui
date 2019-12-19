require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/focus'
require_relative '../src/node'
require_relative '../src/input'

class FocusTest < Test::Unit::TestCase
  def test_next
    c1 = Node.new(
      name: 'child1',
      attributes: { focusable: true }
    )
    c2 = Node.new(
      name: 'child2',
      attributes: { focusable: true }
    )
    root = Node.new(
      text: 'parent',
      children: [c1, c2]
    )
    assert_equal nil, c1.get_attribute(:focused)
    focus = FocusManager.new(root: root, input: Input.new)
    times = 0
    focus.add_listener(:focus, proc { |e|
      if times.zero?
        assert_equal e[:focused], c2
        assert_equal e[:previous], c1
      end
      times += 1
    })
    assert_equal true, c1.get_attribute(:focused)
    focus.focus_next
    assert_equal false, c1.get_attribute(:focused)
    assert_equal true, c2.get_attribute(:focused)
    assert_equal times, 1
  end
end
