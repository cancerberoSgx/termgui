require_relative '../src/renderer'
require_relative '../src/util'
require 'test/unit'
include Test::Unit::Assertions

class RendererTest < Test::Unit::TestCase
  def test_rect_stub
    assert_include "\e[2;2Hllllllll" \
                   "\e[3;2Hllllllll" \
                   "\e[4;2Hllllllll" \
                   "\e[5;2Hllllllll" \
                   "\e[6;2Hllllllll", `ruby test/renderer_test_rect.rb`
  end

  def test_rect
    r = Renderer.new
    s = r.rect x: 2, y: 1, width: 3, height: 2, ch: 'x'
    assert_equal  "\e[2;2Hxxx\e[3;2Hxxx", s
  end

  def test_print
    r2 = Renderer.new 10, 7
    r2.rect x: 2, y: 1, width: 3, height: 2, ch: 'x'
    assert_equal                  '          \\n' \
                 '  xxx     \\n' \
                 '  xxx     \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n', r2.print

    r2.rect x: 4, y: 2, width: 2, height: 3, ch: 'y'
    assert_equal                 '          \\n' \
                 '  xxx     \\n' \
                 '  xxyy    \\n' \
                 '    yy    \\n' \
                 '    yy    \\n' \
                 '          \\n' \
                 '          \\n', r2.print
    r2.clear
    assert_equal '          \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n', r2.print
  end

  def test_circle
    s = Screen.new_for_testing(width: 30, height: 20)
    s.circle(x: 10, y: 10, radius: 6, stroke: Style.new(bg: 'green', fg: 'red'), stroke_ch: 'x', fill: Style.new(bg: 'blue'), fill_ch: 'o')
    assert_equal'                              \n' \
                '                              \n' \
                '                              \n' \
                '                              \n' \
                '        xxxxx                 \n' \
                '       xooooox                \n' \
                '      xooooooox               \n' \
                '     xooooooooox              \n' \
                '    xooooooooooox             \n' \
                '    xooooooooooox             \n' \
                '    xooooooooooox             \n' \
                '    xooooooooooox             \n' \
                '    xooooooooooox             \n' \
                '     xooooooooox              \n' \
                '      xooooooox               \n' \
                '       xooooox                \n' \
                '        xxxxx                 \n' \
                '                              \n' \
                '                              \n' \
                '                              \n', s.print
  end
end
