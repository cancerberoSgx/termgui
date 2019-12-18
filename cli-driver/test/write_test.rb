# frozen_string_literal: true

require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/cli_driver'

# write() tests
class WriteTest < Test::Unit::TestCase
  def test_write
    client = Driver.new
    client.set_timeout(0.5, proc {
      client.write 'from_test_write'
    })
    client.run("ruby -e \"puts 'Please enter message'; msg = gets.strip; puts 'You have entered **'+msg+'** message. '\"")
    assert_equal "Please enter message\r\n" + 'You have entered **from_test_write** message.', client.data_str
  end
end
