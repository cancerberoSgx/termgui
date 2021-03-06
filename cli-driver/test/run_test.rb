# frozen_string_literal: true

require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/cli_driver'

class RunTest < Test::Unit::TestCase
  def test_run
    client = Driver.new
    client.run("node -e 'console.log((12+13).toString())'")
    assert_equal client.data_str, '25'
  end
end
