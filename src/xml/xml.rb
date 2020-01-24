require '/Users/wyeworks/.rubies/ruby-2.6.5/lib/ruby/2.6.0/rexml/document'
require 'erb'
require_relative '../element'
require_relative '../screen'
require_relative '../log'
require_relative '../util'
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
                       is_percent(value.to_f) ? value.to_f : value.to_i
                     elsif code_attrs.include? name
                       eval(value, b)
                     elsif name == 'style'
                       Style.from_hash(eval(value))
                     else
                       value
              end
  end
  a
end

def percent_bounds_hack(result, parent)
  result.set_attribute('xml', true)
  if parent && !parent.get_attribute('xml')
    result.set_attribute('x', 0)
    result.set_attribute('y', 0)
    result.set_attribute('width', parent.width)
    result.set_attribute('height', parent.height)
    # log parent.width, parent.height
  end
end

def process_node(node, parent = nil, b)
  builders = {
    col: Col,
    button: Button,
    label: Label
  }

  if node.is_a?(REXML::Text)
    parent.text += node.to_s.strip if parent
  else
    c = (builders[node.name.to_sym] || Element)
    a = process_attrs(node, b).merge(parent: parent)
    result = c.new(a)
    percent_bounds_hack(result, parent)
    node.each do |e|
      c = process_node(e, result, b)
      # c.x = 21 if c
    end
  end
  result
end

def render_xml(xml: nil, parent: nil, binding: nil)
  doc = REXML::Document.new xml
  process_node(doc, parent, binding)
end

def render_erb(template: nil, parent: nil, binding: nil, erb_binding: binding)
  xml = ERB.new(template).result(erb_binding).strip
  render_xml(xml: xml, parent: parent, binding: binding)
end
