require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/node'

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
    n = Node.new(
      text: 'parent',
      children: [
        Node.new(name: 'child1'),
        Node.new(name: 'child2', children: [
                   Node.new(name: 'child2.1')
                 ])
      ]
    )
    assert_equal 'Node(name: node, children: [Node(name: child1, children: []), ' \
                 'Node(name: child2, children: [Node(name: child2.1, children: [])])])',
                 n.to_s
    a = []
    visit_node(n, proc { |child|
      a.push child.name
      false
    })
    assert_equal ['child1', 'child2.1', 'child2', 'node'], a
  end

  def test_query_by_attribute
    n = Node.new(
      text: 'parent',
      attributes: {
        foo: 'bar'
      },
      children: [
        Node.new(
          name: 'child1',
          attributes: { a: 1.2 }
        ),
        Node.new(
          name: 'child2',
          attributes: { a: 1.2 },
          children: [
            Node.new(
              name: 'child2.1',
              attributes: { a: 1.2 }
            )
          ]
        )
      ]
    )
    result = n.query_by_attribute(:foo, 'bar')
    assert_equal [n], result
    assert_equal ['child1', 'child2.1', 'child2'], n.query_by_attribute(:a, 1.2).map(&:name)
  end

  def test_query_one_by_attribute
    n = Node.new(
      text: 'parent',
      attributes: {
      },
      children: [
        Node.new(
          name: 'child1',
          attributes: { a: 1.2 }
        ),
        Node.new(
          name: 'child2',
          attributes: { a: 1.2 },
          children: [
            Node.new(
              name: 'child2.1',
              attributes: { a: 1.2 }
            )
          ]
        )
      ]
    )
    result = n.query_one_by_attribute(:a, 1.2)
    assert_equal 'child1', result.name
  end

  # def test_append_to
  #   pend
  # end

  # def test_insert_children
  #   pend
  # end

  # def test_remove
  #   pend
  # end

  # def test_parent_prop
  #   pend
  # end
end
