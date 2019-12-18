require_relative 'util'
require_relative 'emitter'

class Node < Emitter
  attr :attributes, :children, :text, :parent, :name
  attr_writer :parent

  def initialize(name: "node", children: [], text: "", attributes: {}, parent: nil)
    @name = name
    @attributes = Attributes.new attributes
    @children = children
    children.each { |child| child.parent = self }
    @text = text
    @parent = parent
  end

  # returns child so something like the following is possible:
  # `@text = append_child(Textarea.new model.text)`
  def append_child(child)
    @children.push(child)
    child.parent = self
    child
  end

  def query_by_attribute(attr, value)
    result = []
    visit_node self, Proc.new { |n|
      if n.attributes.get_attribute(attr) == value
        result.push n
      end
      false
    }
    result
  end

  def query_one_by_attribute(attr, value)
    result = visit_node self, Proc.new { |n|
      n.attributes.get_attribute(attr) == value
    }
    result
  end

  def render(screen)
    render_self screen
    render_children screen
  end

  def render_self(screen)
    throw "Abstract method"
  end

  def render_children(screen)
    @children.each { |c| c.render screen }
  end

  def attributes(attrs=nil)
    attrs.each_key { |key| set_attribute(key.to_s, attrs[key]) } unless attrs==nil
    @attributes
  end

  def set_attribute(name, value)
    @attributes.set_attribute(name, value)
    self
  end

  def get_attribute(name)
    @attributes.get_attribute(name)
  end

  def visit(visitor, children_first = true)
    visit_node(self, visitor, children_first)
  end

  def to_s
    "Node(name: #{name}, children: [#{(children.map { |c| c.to_s }).join(", ")}])"
  end
end

class Attributes
  def initialize(attrs = {})
    @attrs = attrs
  end

  def names
    @attrs.keys
  end

  def set_attribute(name, value)
    @attrs[name] = value
    self
  end

  def get_attribute(name)
    @attrs[name]
  end

  def to_s
    @attrs.to_s
  end
end

# visit given node children bottom-up. If visitor returns truthy then visiting finishes
def visit_node(node, visitor, children_first = true)
  result = nil
  unless children_first
    result = visitor.call node
    return result if result
  end
  result = some node.children, Proc.new { |child|
    visit_node child, visitor, children_first
  }
  return result if result
  result = visitor.call node if children_first
  result
end
