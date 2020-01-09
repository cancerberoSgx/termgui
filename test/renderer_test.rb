require_relative '../src/renderer'
require_relative '../src/util'
require 'test/unit'
include Test::Unit::Assertions

class RendererTest < Test::Unit::TestCase
  def test_rect_stub
    s = `ruby test/renderer_test_rect.rb`
    assert_include s,
                   "\e[2;2Hllllllll" \
                   "\e[3;2Hllllllll" \
                   "\e[4;2Hllllllll" \
                   "\e[5;2Hllllllll" \
                   "\e[6;2Hllllllll",
                   'should print a rectangle with Ls'
  end

  def test_rect
    r = Renderer.new
    s = r.rect x: 2, y: 1, width: 3, height: 2, ch: 'x'
    assert_equal s, "\e[2;2Hxxx\e[3;2Hxxx"
  end

  def test_print
    r2 = Renderer.new 10, 7
    r2.rect x: 2, y: 1, width: 3, height: 2, ch: 'x'
    assert_equal r2.print,
                 '          \\n' \
                 '  xxx     \\n' \
                 '  xxx     \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n'
    r2.rect x: 4, y: 2, width: 2, height: 3, ch: 'y'
    assert_equal r2.print,
                 '          \\n' \
                 '  xxx     \\n' \
                 '  xxyy    \\n' \
                 '    yy    \\n' \
                 '    yy    \\n' \
                 '          \\n' \
                 '          \\n'
    r2.clear
    assert_equal r2.print,
                 '          \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n' \
                 '          \\n'
  end
end
