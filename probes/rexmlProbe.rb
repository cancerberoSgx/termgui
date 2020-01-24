require '/Users/wyeworks/.rubies/ruby-2.6.5/lib/ruby/2.6.0/rexml/document'
require_relative '../src/element'
require_relative '../src/screen'
require_relative '../src/log'
require_relative '../src/style'
require_relative '../src/widget/col'
require_relative '../src/widget/button'
require_relative '../src/widget/label'


def process_attrs(e)
  number_attrs = ['width', 'height', 'x', 'y']
  code_attrs = ['action']
  a = {}
  e.attributes.each_attribute do |attr|
    value = attr.value
    p value
    name =  attr.expanded_name
    a[name.to_sym] = if number_attrs.include? name
                value.to_f
              elsif code_attrs.include? name
                eval(value)
              elsif name == 'style'
                Style.from_hash(eval(value))
              else
                value.to_s
              end
  end
  # p a
  a
end

def process_node(node, parent = nil)

  builders = {
    col: Col,
    button: Button,
    label: Label,
  }

  if node.is_a?(REXML::Text) && parent
    parent.text += node.to_s
  else
    if !builders[node.name.to_sym]
      p 'no found'+node.name+node.class.to_s
    end
    c =  (builders[node.name.to_sym]||Element)
    # p c.name
    a = process_attrs(node).merge(parent: parent)
    result = c.new(a)
    # parent.append_child(result) if parent
    node.each do |e|
      cs = process_node(e, result)
      # c.text = 'asdasd' if c
      # c.x = 21 if c
      # result.append_child cs if cs
    end
  end
  result
end



xml = '
<col width="0.8" height="0.9" x="11" y="3" style="{bg: :blue}">
  <button action="proc {log 123}" style="{bg: :yellow}" x="11" y="11" height="3" width="12">hello</button>
  <button>sss</button>
  <label x="12" y="3" height="3" width="12">hehhe</label>
</col>
'

doc = REXML::Document.new xml

s = Screen.new
s.render
# r = Row.new(height: 0.99, parent:)
# p cc
# cc.each{|c|p c.name+', '+c.get_attribute('x').to_s+', '+c.get_attribute('y').to_s+', '+c.get_attribute('width').to_s+', '+c.get_attribute('height').to_s}
process_node(doc).children.each{|c|s.append_child c}
# s.append_children cc
# p cc[0].children[0].class
# p cc[0].children[0].attributes
s.append_child Button.new(attributes: {x: 3, y: 5}, text: 'sfsdf')
s.render
s.start
# puts process_node(doc).pretty_print

# n = Node.new(name: '1', attributes: {aa: 123}, children: [Node.new(name: '1.1')])
# puts n.pretty_print

# doc.each{|e|
# # if respond_to? :each
#   # result[:children].push process_node(e)
# p e
# }

# # p xml
# d = REXML::Document.new(xml)

# d.each_recursive{|e|
# # {}.each_pair
# p [e.name, e.text, process_attrs(e.attributes), e.attributes['width']]
# # aa = []
# # e.attributes.each_pair{|k, v| aa.push({key: k, value: v})}
# # p aa
# # p e.name, e.attributes["a"]
# }

# def process_attrs(a)
#   a[:width] = a[:width] ? Number(a[:width]) : a[:width]
#   a
# end
