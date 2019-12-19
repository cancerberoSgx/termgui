
require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/cli_driver'

# tests wait_for
class WaitTest < Test::Unit::TestCase
  def test_wait_for
    client = Driver.new
    client.set_timeout(0.1, proc {
      client.wait_for predicate: proc { client.data_str.include? 'seba' },
                      block: proc { |timeout|
                               if timeout
                                 assert false
                               else
                                 assert true
                               end
                             }
      assert_true true
    })
    client.run("ruby -e \"sleep 0.5; puts 'seba'\"")
  end

  def test_wait_for_2
    client = Driver.new
    client.set_timeout(0.1, proc {
      client.wait_for predicate: proc { client.data_str.include? 'does not match' },
                      block: proc { |timeout|
                               if timeout
                                 assert true
                               else
                                 assert false
                               end
                             }
    })
    client.run("ruby -e \"sleep 0.4; puts 'seba'\"")
  end
end
