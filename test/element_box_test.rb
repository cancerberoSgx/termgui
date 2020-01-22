require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/element_box'
require_relative '../src/screen'
require_relative '../src/element'
require_relative '../src/geometry'

class NodeTest < Test::Unit::TestCase
  def test_bounds
    # TODO: move to geometry_test
    o = Bounds.new(top: 2, left: 1, right: 3, bottom: 4)
    assert_equal o.top, 2
    o.top = 6
    assert_equal o.top, 6
  end

  def test_render_text
    s = Screen.new(width: 12, height: 7, silent: true)
    e = Element.new(x: 1, y: 2, width: 9, height: 3, text: 'hello', ch: '·', style: { padding: Bounds.new(top: 1, left: 2) })
    s.append_child(e)
    s.render
    assert_equal(
      '            \\n' \
      '            \\n' \
      ' ·········  \\n' \
      ' ··hello··  \\n' \
      ' ·········  \\n' \
      '            \\n' \
      '            \\n' \
    '', s.print
    )
  end

  def test_render_offset
    s = Screen.new(width: 12, height: 7, silent: true)
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
