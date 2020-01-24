require '/Users/wyeworks/.rubies/ruby-2.6.5/lib/ruby/2.6.0/rexml/document'
# require 'rexml'
require_relative '../element'
require_relative '../screen'
require_relative '../log'
require_relative '../style'
require_relative '../widget/col'
require_relative '../widget/button'
require_relative '../widget/label'

def process_attrs(e, b)
  number_attrs = %w[width height x y]
  code_attrs = ['action']
  a = {}
  e.attributes.each_attribute do |attr|
    value = attr.value
    name =  attr.expanded_name
    a[name.to_sym] = if number_attrs.include? name
                       value.to_f
                     elsif code_attrs.include? name
                       # proc {eval(value, b)}.call(b)
                       eval(value, b)
                     elsif name == 'style'
                       Style.from_hash(eval(value))
                     else
                       value.to_s
              end
  end
  # p a
  a
end

def process_node(node, parent = nil, b)
  builders = {
    col: Col,
    button: Button,
    label: Label
  }

  if node.is_a?(REXML::Text) && parent
    parent.text += node.to_s.strip
  else
    # if !builders[node.name.to_sym]
    # p 'no found'+node.name+node.class.to_s
    # end
    c = (builders[node.name.to_sym] || Element)
    # p c.name
    a = process_attrs(node, b).merge(parent: parent)
    result = c.new(a)
    # parent.append_child(result) if parent
    node.each do |e|
      cs = process_node(e, result, b)
      # c.text = 'asdasd' if c
      # c.x = 21 if c
      # result.append_child cs if cs
    end
  end
  result
end

def render_xml(xml: nil, parent: nil, binding: nil)
  doc = REXML::Document.new xml
  process_node(doc, nil, binding).children.each { |c| parent.append_child c }
end
