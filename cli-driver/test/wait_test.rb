require "test/unit"
include Test::Unit::Assertions
require_relative "../src/cli_driver"

class WaitTest < Test::Unit::TestCase
  def test_wait_for
    client = Driver.new
    client.set_timeout 0.1, Proc.new {
      client.wait_for predicate: Proc.new {
          client.data_str.include? "seba"
        },
        block: Proc.new { |timeout|
          if timeout
            assert false
            # p 'TIMEOUT ERROR'
          else
            # p 'matched'
            assert true
          end
        }
      assert_true true
    }
    client.run("ruby -e \"sleep 0.5; puts 'seba'\"")
  end

  def test_wait_for_2
    client = Driver.new
    client.set_timeout 0.1, Proc.new {
      client.wait_for predicate: Proc.new {
          client.data_str.include? "does not match"
        },
        block: Proc.new { |timeout|
          if timeout
            assert true
            # p 'TIMEOUT ERROR'
          else
            # p 'matched'
            assert false
          end
        }
    }
    client.run("ruby -e \"sleep 0.4; puts 'seba'\"")
  end
end
