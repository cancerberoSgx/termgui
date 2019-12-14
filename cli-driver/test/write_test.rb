require "test/unit"
include Test::Unit::Assertions
require_relative "../src/cli_driver"

class TimeoutTest < Test::Unit::TestCase
  def test_write
    client = Driver.new
    client.set_timeout 0.5, Proc.new {
      client.write "from_test_write"
    }
    client.run("ruby -e \"puts 'Please enter message'; msg = gets.strip; puts 'You have entered **'+msg+'** message. '\"")
    assert_equal "Please enter message\r\n" + "You have entered **from_test_write** message.", client.data_str
  end
end
