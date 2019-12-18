require "test/unit"
include Test::Unit::Assertions
require_relative "../src/input"

class InputTest < Test::Unit::TestCase
  def test_set_timeout
    i = Input.new
    t = nil
    i.set_timeout 0.2, Proc.new {
      t = "timeout"
      i.stop
    }
    i.start
    assert_equal t, "timeout"
  end
end
