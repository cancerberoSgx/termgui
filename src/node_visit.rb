# adds node recirsive visit support and node query operations
module NodeVisit
  def query_by_attribute(attr, value)
    result = []
    visit_node(self, proc { |n|
      result.push n if n.attributes.get_attribute(attr) == value
      false
    })
    result
  end

  def query_by_name(name)
    result = []
    visit_node(self, proc { |n|
      result.push n if n.name == name
      false
    })
    result
  end

  def query_one_by_attribute(attr, value)
    result = nil
    p = proc do |n|
      if n.attributes.get_attribute(attr) == value
        result = n
        true
      else
        false
      end
    end
    visit_node(self, p)
    result
  end

  def visit(visitor, children_first = true)
    visit_node(self, visitor, children_first)
  end
end

# visit given node children bottom-up. If visitor returns truthy then visiting finishes
def visit_node(node, visitor, children_first = true)
  result = nil
  unless children_first
    result = visitor.call node
    return result if result
  end
  result = some(node.children, proc { |child| visit_node child, visitor, children_first })
  return result if result

  result = visitor.call node if children_first
  result
end
