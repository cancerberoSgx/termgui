require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/input'

class InputTest < Test::Unit::TestCase
  def test_set_timeout
    i = Input.new
    t = nil
    i.set_timeout(0.1, proc {
      t = 'timeout'
      i.stop
    })
    i.start
    assert_equal t, 'timeout'
  end

  def test_set_timeout_block
    i = Input.new
    t = nil
    i.set_timeout(0.1) do
      t = 'timeout'
      i.stop
    end
    i.start
    assert_equal t, 'timeout'
  end

  def test_wait_for
    i = Input.new
    t = nil
    y = nil
    i.wait_for(proc { t == 1 }) do |timeout|
      assert_equal false, timeout
      assert_equal 1, t
      y = 'works'
      i.stop
    end
    i.set_timeout(0.2) do
      t = 1
    end
    assert_equal nil, t
    assert_equal nil, y
    i.start
    assert_equal y, 'works'
    assert_equal 1, t
  end
end
