require_relative 'util'
require_relative 'node_attributes'
require_relative 'node_visit'
require_relative 'emitter'

# analog to HTML DOM Node class
class Node < Emitter
  include NodeVisit

  attr_reader :children, :text, :parent, :name
  attr_writer :parent

  def initialize(name: 'node', children: [], text: '', attributes: {}, parent: nil)
    @name = name
    @attributes = Attributes.new attributes
    @children = children
    children.each { |child| child.parent = self }
    @text = text
    @parent = parent
    install(:after_render)
    install(:before_render)
  end

  # returns child so something like the following is possible:
  # `@text = append_child(Textarea.new model.text)`
  def append_child(*children)
    children.each do |child|
      @children.push(child)
      child.parent = self
    end
    children.sample
  end

  def render(screen)
    trigger(:before_render)
    render_self screen
    render_children screen
    render_text screen
    trigger(:after_render)
  end

  def render_self(_screen)
    throw 'Abstract method'
  end

  def render_children(_screen)
    throw 'Abstract method'
  end

  def render_text(_screen)
    throw 'Abstract method'
  end

  def attributes(attrs = nil)
    attrs&.each_key { |key| set_attribute(key.to_s, attrs[key]) }
    @attributes
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
end
