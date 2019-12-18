# frozen_string_literal: true

require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/cli_driver'

class TimeoutTest < Test::Unit::TestCase
  def test_timeout
    client = Driver.new
    client.set_timeout 0.5, proc {
      assert_equal client.data_str, 'seba'
    }
    client.run("ruby -e \"puts 'seba'; sleep 1; puts 'bye'\"")
    assert_equal "seba\r\nbye", client.data_str
  end
end
