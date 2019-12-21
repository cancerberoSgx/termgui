require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/util'

class A
  attr_writer :a, :b
  attr_reader :a, :b
  def initialize
    @a = 1
    @b = 1
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

  def test_merge_hash_into_object
    a = A.new
    a.a = 2
    a.b = 0
    merge_hash_into_object({ b: 1 }, a)
    assert_equal [2, 1], [a.a, a.b]
    merge_hash_into_object({ b: 2 }, a)
    assert_equal [2, 2], [a.a, a.b]
  end

  def test_object_variables_to_hash
    a = A.new
    a.a = 2
    a.b = 3
    hash = object_variables_to_hash(a)
    assert_equal({a: 2, b: 3}, hash)
  end
end
