require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/util/wrap'

class WrapTest < Test::Unit::TestCase
  def test_simple
    w = Wrapper.new('some long long long tyext text', 13)
    assert_equal "some long\nlong long\ntyext text\n", w.wrap
    assert_equal "some long\nlong long\ntyext text\n", w.fit
  end
end
