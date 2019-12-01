require "test/unit"
include Test::Unit::Assertions
require_relative '../src/node'

class NodeTest < Test::Unit::TestCase
  def test_children
    n=Node.new
    assert_equal n.children, []
    c=Node.new
    n.appendChild c
    assert_equal n.children, [c]
    assert_equal c.children, []
  end  
end
 