require "test/unit"
include Test::Unit::Assertions
require_relative "../src/element"
require_relative "../src/util"
require_relative "../src/screen"

class NodeTest < Test::Unit::TestCase
  def test_abs
    child2 = Element.new(x: 2, y: 1)
    child1 = Element.new(x: 4, y: 3, children: [child2])
    node = Element.new(children: [child1])

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
    child2 = Element.new(x: 2, y: 1, width: 2, height: 1, ch: "2")
    child1 = Element.new(x: 4, y: 3, width: 10, height: 8, ch: "1", children: [child2])
    node = Element.new(children: [child1])
    screen = Screen.new(width: 16, height: 11)
    node.render screen
    s3 =
      "                \\n" +
      "                \\n" +
      "                \\n" +
      "    1111111111  \\n" +
      "    1122111111  \\n" +
      "    1111111111  \\n" +
      "    1111111111  \\n" +
      "    1111111111  \\n" +
      "    1111111111  \\n" +
      "    1111111111  \\n" +
      "    1111111111  \\n" +
      ""
    assert_equal s3, screen.renderer.print
  end

  def test_style
    s = Style.new(border: Border.new(style: "classic", fg: "red"), fg: "blue", bg: "bright_magenta")
    assert_equal "classic", s.border.style
    assert_equal "red", s.border.fg
    assert_equal "blue", s.fg

    e = Element.new
    e.style = {      fg: "black", bg: "white"    }
    assert_equal e.style.fg, "black"
    assert_equal e.style.bg, "white"

    e.style = s
    assert_equal "classic", e.style.border.style
    assert_equal "red", e.style.border.fg

    assert_equal e.style.fg, "blue"
  end
end
