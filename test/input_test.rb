require "test/unit"
include Test::Unit::Assertions
require_relative '../src/input'
require 'timeout'

class InputTest < Test::Unit::TestCase
  def test_subscribe
    i=Input.new
    i.subscribe('key', Proc.new {|e| 
      puts e[:key]
    })
    i.start
    status = Timeout::timeout(0.3) {
      
    }
end
 