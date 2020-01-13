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
end
