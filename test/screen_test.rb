require "test/unit"
include Test::Unit::Assertions
require_relative "../src/screen"

class ScreenTest < Test::Unit::TestCase
  def test_renderer
    s = Screen.new 5, 6
    r = s.renderer
    assert_equal r.buffer.length, 6
    assert_equal r.buffer[0].length, 5
  end

end
