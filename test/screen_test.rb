require "test/unit"
include Test::Unit::Assertions
require_relative "../src/screen"
require_relative "../src/util"

class ScreenTest < Test::Unit::TestCase
  def test_renderer
    s = Screen.new width: 5, height: 6
    r = s.renderer
    assert_equal r.buffer.length, 6
    assert_equal r.buffer[0].length, 5
  end

  def test_rect
    s = Screen.new width: 12, height: 7
    s.rect(x: 1, y: 2, width: 3, height: 2, ch: "f")
    assert_equal ["            ",
                  "            ",
                  " fff        ",
                  " fff        ",
                  "            ",
                  "            ",
                  "            "],
                 s.print.split('\n')
  end
end
