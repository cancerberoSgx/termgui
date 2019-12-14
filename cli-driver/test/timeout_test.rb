require "test/unit"
include Test::Unit::Assertions
require_relative "../src/cli_driver"

class TimeoutTest < Test::Unit::TestCase
  def test_timeout
    client = Driver.new    
    client.set_timeout 0.5, Proc.new {
      assert_equal client.data.join('').strip, 'seba'
    }
    client.run("ruby -e \"puts 'seba'; sleep 1; puts 'bye'\"")
    assert_equal "seba\r\nbye", client.data.join('').strip
  end
end
