require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/element'
require_relative '../src/util'
require_relative '../src/style'
require_relative '../src/screen'
require_relative '../src/log'

class NodeTest < Test::Unit::TestCase
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

  def test_render
    child2 = Element.new(x: 2, y: 1, width: 2, height: 1, ch: '2')
    child1 = Element.new(x: 4, y: 3, width: 10, height: 8, ch: '1', children: [child2])
    node = Element.new(children: [child1])
    screen = Screen.new(width: 16, height: 11)
    screen.silent = true
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

  def test_style
    s = Style.new(border: Border.new(style: 'classic', fg: 'red'), fg: 'blue', bg: 'bright_magenta')
    assert_equal 'classic', s.border.style
    assert_equal 'red', s.border.fg
    assert_equal 'blue', s.fg

    e = Element.new
    e.style = { fg: 'black', bg: 'white' }
    assert_equal 'black', e.style.fg
    assert_equal 'white', e.style.bg

    e.style = s
    assert_equal 'classic', e.style.border.style
    assert_equal 'red', e.style.border.fg
    assert_equal 'blue', e.style.fg
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

  def test_render_text
    s = Screen.new(width: 12, height: 7)
    s.silent = true
    e = Element.new(x: 1, y: 2, width: 6, height: 3, text: 'hello', ch: '·')
    s.append_child(e)
    s.render
    # p s.print
    assert_equal(
      '            \\n' \
      '            \\n' \
      ' hello·     \\n' \
      ' ······     \\n' \
      ' ······     \\n' \
      '            \\n' \
      '            \\n' \
    '', s.print
    )
  end

  def test_constructor_style
    e = Element.new(
      attributes: { focusable: true, focused: false },
      style: {
        focus: Style.new(bg: 'red')
      }
    )
    assert_equal 'red', e.style.focus.bg
    assert_equal true, e.get_attribute('focusable')
    assert_equal true, e.get_attribute(:focusable)
    assert_equal false, e.get_attribute(:focused)
    assert_equal false, e.get_attribute('focused')
    assert_equal nil, e.style.border
    e.style.border = Border.new
    assert_equal Border.new.style, e.style.border.style
    assert_equal ({ bg: nil, blink: nil, bold: nil, fg: nil, style: 'single' }), e.style.border.to_hash
    assert object_equal({ bg: nil, blink: nil, bold: nil, fg: nil, style: 'single' }, e.style.border.to_hash)

    assert_equal(e.style.focus.bg, 'red')
  end

  # def test_style_no_focus_if_not_declared
  #   e = Element.new
  #   assert_equal nil, e.style.focus
  #   assert_equal nil, e.style.border
  # end

  def test_final_style
    e = Element.new(
      attributes: { focusable: true, focused: false },
      style: {
        bg: 'white',
        focus: Style.new(bg: 'red')
      }
    )
    assert_equal 'red', e.style.focus.bg
    assert_equal 'white', e.final_style.bg
    assert_equal false, e.get_attribute('focused')
    e.set_attribute('focused', true)
    assert_equal true, e.get_attribute('focused')
    # p e.style.focus.bg
    # e.final_stylew
    # e.final_style
    assert_equal 'red', e.final_style.bg
  end
end
