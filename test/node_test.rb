require "test/unit"
include Test::Unit::Assertions
require_relative '../src/node'
require 'fileutils'

class MainTest < Test::Unit::TestCase
  def test_children
    n=Node.new
    assert_equal n.children, []
  end  
end
 