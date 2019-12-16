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

  def test_query_by_attribute
    n = Node.new(text: "parent", attributes: {
      foo: 'bar'
    }, children: [
      Node.new(name: "child1", attributes: {a: 1.2}),
      Node.new(name: "child2", attributes: {a: 1.2}, children: [
                 Node.new(name: "child2.1", attributes: {a: 1.2}),
               ]),
    ])
    result=n.query_by_attribute(:foo, 'bar')
    assert_equal [n], result
    assert_equal ["child1", "child2.1", "child2"], n.query_by_attribute(:a, 1.2).map{|n|n.name}
  end
end
