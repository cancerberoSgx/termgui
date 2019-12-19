
require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/util'

class UtilTest < Test::Unit::TestCase
  def test_some
    a = [1, 2, 3, 4, 5]
    b = []
    result = some(a, proc do |i|
      b.push i
      i == 3
    end)
    assert_equal [1, 2, 3], b
    assert_equal 3, result
  end
end
