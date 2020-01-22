require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/geometry'

class GeometryTest < Test::Unit::TestCase
  def test_bounds
    o = Bounds.new(top: 2, left: 1, right: 3, bottom: 4)
    assert_equal 2, o.top
    o.top = 6
    assert_equal 6, o.top
  end
end
