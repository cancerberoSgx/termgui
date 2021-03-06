require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/element'
require_relative '../src/util'
require_relative '../src/style'
require_relative '../src/screen'
require_relative '../src/log'

class ElementRenderTest < Test::Unit::TestCase
  def test_render
    child2 = Element.new(x: 2, y: 1, width: 2, height: 1, ch: '2')
    child1 = Element.new(x: 4, y: 3, width: 10, height: 8, ch: '1', children: [child2])
    node = Element.new(children: [child1])
    screen = Screen.new_for_testing(width: 16, height: 11)
    node.render screen
    s3 =
      '                \\n' \
      '                \\n' \
      '                \\n' \
      '    1111111111  \\n' \
      '    1122111111  \\n' \
      '    1111111111  \\n' \
      '    1111111111  \\n' \
      '    1111111111  \\n' \
      '    1111111111  \\n' \
      '    1111111111  \\n' \
      '    1111111111  \\n' \
      ''
    assert_equal s3, screen.renderer.print
  end

  def test_render_text1
    screen = Screen.new_for_testing(width: 12, height: 7)
    e = Element.new(x: 1, y: 2, width: 6, height: 3, text: 'hello', ch: '·')
    screen.append_child(e)
    screen.render
    assert_equal(
      '            \\n' \
      '            \\n' \
      ' hello·     \\n' \
      ' ······     \\n' \
      ' ······     \\n' \
      '            \\n' \
      '            \\n' \
    '', screen.print
    )
  end

  def test_render_text2
    screen = Screen.new_for_testing(width: 12, height: 7)
    e = Element.new(x: 1, y: 2, width: 9, height: 3, text: 'hello', ch: '·', style: { padding: Bounds.new(top: 1, left: 2) })
    screen.append_child(e)
    screen.render
    assert_equal(
      '            \\n' \
      '            \\n' \
      ' ·········  \\n' \
      ' ··hello··  \\n' \
      ' ·········  \\n' \
      '            \\n' \
      '            \\n' \
    '', screen.print
    )
  end

  def test_render_border
    screen = Screen.new_for_testing(width: 12, height: 9)
    e = Element.new(x: 1, y: 2, width: 6, height: 3, text: 'hello', ch: '·')
    e.style.border = Border.new
    screen.append_child(e)
    screen.render
    assert_equal(
      '            \n' \
'            \n' \
' ┌──────┐   \n' \
' │hello·│   \n' \
' │······│   \n' \
' │······│   \n' \
' └──────┘   \n' \
'            \n' \
'            \n' \
      '', screen.print
    )
  end

  def test_render_text_nl
    screen = Screen.new_for_testing(width: 12, height: 7)
    e = Element.new(x: 1, y: 2, width: 6, height: 3, text: 'hello\nworld', ch: '·')
    e.style.border = Border.new
    screen.append_child(e)
    screen.render
    assert_equal(
      '            \n' \
      '            \n' \
      ' ┌──────┐   \n' \
      ' │hello·│   \n' \
      ' │world·│   \n' \
      ' │······│   \n' \
      ' └──────┘   \n' \
      '', screen.print
    )
  end

  def test_render_text_wrap
    screen = Screen.new_for_testing(width: 16, height: 9)
    e = Element.new(x: 1, y: 1, width: 12, height: 5, text: 'as df rf ty gh fg sdf ed', ch: '·')
    e.style.border = Border.new
    e.style.wrap = true
    screen.append_child(e)
    screen.render
    assert_equal(
      '                \n' \
      ' ┌────────────┐ \n' \
      ' │as df rf ty·│ \n' \
      ' │gh fg sdf ed│ \n' \
      ' │············│ \n' \
      ' │············│ \n' \
      ' │············│ \n' \
      ' └────────────┘ \n' \
      '                \n' \
      '', screen.print
    )
  end
end
