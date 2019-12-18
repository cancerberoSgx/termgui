# frozen_string_literal: true

require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/input'

class InputTest < Test::Unit::TestCase
  def test_set_timeout
    i = Input.new
    t = nil
    i.set_timeout 0.2, proc {
      t = 'timeout'
      i.stop
    }
    i.start
    assert_equal t, 'timeout'
  end
end
