require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/element'
require_relative '../src/util'
require_relative '../src/style'
require_relative '../src/screen'
require_relative '../src/log'

class ElementStyleTest < Test::Unit::TestCase
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
