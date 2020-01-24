require_relative 'util'
require_relative 'node_attributes'
require_relative 'node_visit'
require_relative 'emitter'

module TermGui
  # analog to HTML DOM Node class
  # Ways of declaring node hierarchies by using parent and children props, or append_child or append_to methods. For declarative complex structures probably you want to use children
  # `main = Row.new(parent: screen, height: 0.5, children: [Button.new(text: 'clickme', Col.new(width: 0.8, x: 0.2, children: [Label.new(text: 'hello')]))])`
  # or
  # `main = screen.append_child(Row.new(height: 0.5, children: [Button.new(text: 'clickme', Col.new(width: 0.8, x: 0.2, children: [Label.new(text: 'hello')]))]))`
  # or
  # `main = Row.new(height: 0.5, children: [Button.new(text: 'clickme', Col.new(width: 0.8, x: 0.2, children: [Label.new(text: 'hello')]))]).append_to(screen)`
  class Node < Emitter
    include NodeVisit

    attr_reader :children, :text, :parent, :name
    attr_writer :parent, :text

    def initialize(**args)
      @name = args[:name] || 'node'
      @attributes = Attributes.new args[:attributes] || {}
      @children = args[:children] || []
      children.each { |child| child.parent = self }
      @text = args[:text] || ''
      args[:parent]&.append_children(self)
      install(%i[after_render before_render])
    end

    # returns child so we can write:  `button = screen.append_child Row.new(text: 'click me')`
    def append_children(*children)
      children.each do |child|
        @children.push(child)
        child.parent = self
      end
      children
    end

    def append_child(child)
      (append_children child)[0]
    end

    def insert_children(index = 0, *children)
      @children.insert(index, *children)
      children
    end

    def prepend_child(child)
      insert_child(0, child)
    end

    def insert_child(index, child)
      (insert_children index, child)[0]
    end

    def remove_children(*children)
      children.each do |child|
        @children.delete(child)
        child.parent = self
      end
      children
    end

    def remove_child(child)
      (remove_children child)[0]
    end

    def append_to(parent)
      parent.append_child(self)
      self
    end

    def remove
      parent&.remove_child(self)
      self.parent = nil
    end

    def empty
      children.each do |child|
        child.parent = nil
      end
      @children = []
      self
    end

    def attributes(attrs = nil)
      attrs&.each_key { |key| set_attribute(key.to_s, attrs[key]) }
      @attributes
    end

    def attributes=(attrs = nil)
      attributes(attrs)
    end

    def set_attribute(name, value)
      @attributes.set_attribute(name, value)
      self
    end

    def get_attribute(name)
      @attributes.get_attribute(name)
    end

    def to_s
      "Node(name: #{name}, children: [#{children.map(&:to_s).join(', ')}])"
    end

    def pretty_print(d = 0)
      "#{(' ' * d)}<#{name} #{(attributes.pairs.map { |p| "#{p[:name]}=#{pretty_print_attribute p[:value]}" }).join(' ')}>\n#{' ' * (d + 1)}#{text ? " #{text}\n#{' ' * d}" : ''}#{children.map { |c| c.pretty_print d + 1 }.join("\n" + (' ' * d))}\n#{(' ' * (d + 1))}</#{name}>"
    end

    def pretty_print_attribute(a)
      a.respond_to?(:pretty_print) ? a.pretty_print : a.to_s
    end
  end
end
Node = TermGui::Node
