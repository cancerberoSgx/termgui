require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/element_box'
require_relative '../src/screen'
require_relative '../src/element'

class NodeTest < Test::Unit::TestCase
  def test_offset
    o = Offset.new(top: 2, left: 1, right: 3, bottom: 4)
    assert_equal o.top, 2
    o.top = 6
    assert_equal o.top, 6
  end

  def test_render_text
    s = Screen.new(width: 12, height: 7)
    e = Element.new(x: 1, y: 2, width: 9, height: 3, text: 'hello', ch: '·', style: { padding: Offset.new(top: 1, left: 2) })
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
end
