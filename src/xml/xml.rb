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

def process_attrs(e, b, attrs = default_attrs)
  a = {}
  e.attributes.each_attribute do |attr|
    value = attr.value
    name =  attr.expanded_name
    a[name.to_sym] = if attrs[:number].include? name
                       is_percent(value.to_f) ? value.to_f : value.to_i
                     elsif attrs[:code].include? name
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
  end
end

def process_node(node, parent = nil, bindings = nil, builders = default_builders, attrs = default_attrs)
  if node.is_a?(REXML::Text)
    parent.text += node.to_s.strip if parent
  else
    c = (builders[node.name.to_sym] || Element)
    a = process_attrs(node, bindings, attrs).merge(parent: parent)
    result = c.new(a.merge(builders[node.name.to_sym] ? {} : {name: node.name}))
    percent_bounds_hack(result, parent)
    node.each do |e|
      c = process_node(e, result, bindings, builders, attrs)
    end
  end
  result
end

def default_attrs
  {
    number: %w[width height x y],
    code: ['action']
  }
end
def default_builders 
  {
    col: Col,
    button: Button,
    label: Label
  }
end

def render_xml(xml: nil, parent: nil, binding: nil, custom_builders: {}, custom_attrs: {})
  builders = default_builders.merge(custom_builders)
  attrs = default_attrs.merge(custom_attrs)
  doc = REXML::Document.new xml
  process_node(doc, parent, binding, builders, attrs)
end

def render_erb(template: nil, parent: nil, binding: nil, erb_binding: binding, custom_builders: {}, custom_attrs: {})
  xml = ERB.new(template).result(erb_binding).strip
  render_xml(xml: xml, parent: parent, binding: binding, custom_builders: custom_builders, custom_attrs: custom_attrs)
end
