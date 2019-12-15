require "test/unit"
include Test::Unit::Assertions
require_relative "../src/node"

class NodeTest < Test::Unit::TestCase
  def test_children
    n = Node.new
    assert_equal n.children, []
    c = Node.new
    n.append_child c
    assert_equal n.children, [c]
    assert_equal c.children, []
  end

  def test_visit_node
    n = Node.new(text: "parent", children: [
                   Node.new(name: "child1"),
                   Node.new(name: "child2", children: [
                              Node.new(name: "child2.1"),
                            ]),
                 ])
    assert_equal "Node(name: node, children: [Node(name: child1, children: []), Node(name: child2, children: [Node(name: child2.1, children: [])])])", n.to_s
    a = []
    visit_node n, Proc.new { |n| a.push(n.name); false }
    assert_equal ["child1", "child2.1", "child2", "node"], a
  end
end
