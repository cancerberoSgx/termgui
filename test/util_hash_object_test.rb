require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/util'
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
    a = A.new(3,4)
    b = A.new(8,9)
    c = a.assign(b)
    assert_equal "{:a=>8, :b=>9, :c=>nil}", c.to_s
  end

  def test_new_from_hash
    a = A.new
    b = a.new_from_hash({a: 2, b: 4, c: 8})
    assert_equal "{:a=>2, :b=>4, :c=>8}", b.to_s
  end
end
