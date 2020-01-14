require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/util'
require_relative '../src/log'
require_relative '../src/util/hash_object'

class A
  include HashObject
  attr_writer :a, :b, :c
  attr_reader :a, :b, :c
  def initialize(a = 0, b = 0)
    @a = a
    @b = b
    @c = nil
  end
end

class UtilHashObjectTest < Test::Unit::TestCase
  def test_assign
    a = A.new(3, 4)
    b = A.new(8, 9)
    c = a.assign(b)
    assert_equal '{:a=>8, :b=>9, :c=>nil}', c.to_s
    assert a == c
    assert b != c
  end

  def test_assign_nil
    a = A.new(3, 4)
    c = a.assign(nil)
    assert a == c
    assert_equal '{:a=>3, :b=>4, :c=>nil}', c.to_s, 'passing src==nil should not affect the object'
  end

  def test_assign_hash
    a = A.new(3, 4)
    c = a.assign(c: 1, a: 2)
    assert a == c
    assert_equal '{:a=>2, :b=>4, :c=>1}', c.to_s
  end

  def test_new_from_hash
    a = A.new
    b = a.new_from_hash(a: 2, b: 4, c: 8)
    assert_equal '{:a=>2, :b=>4, :c=>8}', b.to_s
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
    a = A.new 2, 3
    hash = object_variables_to_hash(a)
    assert_equal({ a: 2, b: 3, c: nil }, hash)
  end

  def test_object_assign
    a = A.new 2, 3
    a2 = A.new 4, 5
    a2.c = 6
    object_assign(a2, a)
    assert_equal [6, 2, 3], [a2.c, a2.a, a2.b]
    assert_equal [nil, 2, 3], [a.c, a.a, a.b]
  end

  def test_object_equal
    a = A.new 2, 3
    b = A.new 4, 5
    assert_equal false, object_equal(a, b)
    assert_equal true, object_equal(a, a)
    assert_equal true, object_equal(a, a.clone)
    assert_equal true, object_equal(a, A.new(2, 3))
    a.c = 9
    assert_equal false, object_equal(a, A.new(2, 3))
    assert_equal false, object_equal(a, b)
    a.a = 4
    a.b = 5
    assert_equal false, object_equal(a, b)
    b.c = 9
    assert_equal true, object_equal(a, b)
  end

  def test_variable_key
    assert_equal :a, variable_key('@a')
  end
end
