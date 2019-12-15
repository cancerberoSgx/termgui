require "test/unit"
include Test::Unit::Assertions
require_relative "../src/util"

class UtilTest < Test::Unit::TestCase
  def test_some
    a = [1, 2, 3, 4, 5]
    b = []
    some(a, Proc.new { |i|
      b.push i
      i == 3
    })
    assert_equal [1, 2, 3], b
  end
end
