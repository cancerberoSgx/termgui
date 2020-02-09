require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/element'
require_relative '../src/util'
require_relative '../src/style'
require_relative '../src/screen'
require_relative '../src/log'

class ElementBoundsTest < Test::Unit::TestCase
  def test_abs
    child2 = Element.new(x: 2, y: 1)
    child1 = Element.new(x: 4, y: 3, children: [child2])

    assert_equal 2, child2.x
    assert_equal 1, child2.y
    assert_equal 4, child1.x
    assert_equal 3, child1.y

    assert_equal 6, child2.abs_x
    assert_equal 4, child2.abs_y
    assert_equal 4, child1.abs_x
    assert_equal 3, child1.abs_y
  end

  def test_abs_percent
    e = Element.new(x: 1, y: 2, width: 16, height: 12)
    e1 = Element.new(x: 0.3, y: 0.2, width: 0.6, height: 0.6)
    e.append_child(e1)
    assert_equal 9, e1.abs_width
    assert_equal 7, e1.abs_height
    assert_equal 4, e1.abs_y
    assert_equal 5, e1.abs_x
  end

  def test_render_offset
    s = Screen.new_for_testing(width: 12, height: 7, silent: true)
    s.append_child Element.new(x: 7, y: 3, width: 7, height: 12, text: 'hello', ch: '·', style: { border: Border.new, padding: Bounds.new(top: 1, left: 2) })
    s.clear
    s.render

    assert_equal(
      '            \n' \
      '            \n' \
      '      ┌─────\n' \
      '      │·····\n' \
      '      │··hel\n' \
      '      │·····\n' \
      '      │·····\n', s.renderer.print
    )

    s.offset.left = 5
    s.clear
    s.render
    assert_equal(
      '            \n' \
      '            \n' \
      ' ┌───────┐  \n' \
      ' │·······│  \n' \
      ' │··hello│  \n' \
      ' │·······│  \n' \
      ' │·······│  \n', s.renderer.print
    )

    s.offset.top = 2
    s.clear
    s.render
    assert_equal(
      ' ┌───────┐  \n' \
      ' │·······│  \n' \
      ' │··hello│  \n' \
      ' │·······│  \n' \
      ' │·······│  \n' \
      ' │·······│  \n' \
      ' │·······│  \n', s.renderer.print
    )
  end
end
