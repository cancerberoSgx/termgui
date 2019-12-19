require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/element'
require_relative '../src/util'
require_relative '../src/style'
require_relative '../src/screen'
require_relative '../src/log'

class NodeTest < Test::Unit::TestCase

  def test_render_border
    s = Screen.new(width: 12, height: 7)
    e = Element.new(x: 1, y: 2, width: 6, height: 3, text: 'hello', ch: '·')
    e.style.border = Border.new
    s.append_child(e)
    s.silent = true
    s.render
    assert_equal(
      '            \\n' \
      '┌──────┐    \\n' \
      '│hello·│    \\n' \
      '│······│    \\n' \
      '│······│    \\n' \
      '└──────┘    \\n' \
      '            \\n' \
      '', s.print
    )
  end

  def test_render_text_nl
    s = Screen.new(width: 12, height: 7)
    e = Element.new(x: 1, y: 2, width: 6, height: 3, text: 'hello\nworld', ch: '·')
    e.style.border = Border.new
    s.append_child(e)
    s.silent = true
    s.render
    assert_equal(
      '            \\n' \
      '┌──────┐    \\n' \
      '│hello·│    \\n' \
      '│world·│    \\n' \
      '│······│    \\n' \
      '└──────┘    \\n' \
      '            \\n' \
      '', s.print
    )
  end

  # def test_render_text_wrap
  #   s = Screen.new(width: 12, height: 7)
  #   e = Element.new(x: 1, y: 1, width: 0.99, height: 0.99, text: 'very long string needs wrap', ch: '·')
  #   e.style.border = Border.new
  #   e.style.wrap = true
  #   s.append_child(e)
  #   s.silent = true
  #   s.render
  #   # assert_equal(
  #   #   '            \\n' \
  #   #   '┌──────┐    \\n' \
  #   #   '│hello·│    \\n' \
  #   #   '│world·│    \\n' \
  #   #   '│······│    \\n' \
  #   #   '└──────┘    \\n' \
  #   #   '            \\n' \
  #   #   '', s.print
  #   # )
  #   # s.stop
  #   # p s.print
  # end
end
