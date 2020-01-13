require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/util'

class A
  attr_writer :a, :b, :c
  attr_reader :a, :b, :c
  def initialize(a = 0, b = 0)
    @a = a
    @b = b
    @c = nil
  end
end

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
