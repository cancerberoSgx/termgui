require '/Users/wyeworks/.rubies/ruby-2.6.5/lib/ruby/2.6.0/rexml/document'
# require 'rexml'
# require 'FileUtils'
require_relative '../src/xml/xml'

# FileUtil::
# File.expand_path
# require_relative '../src/screen'
# require_relative '../src/log'
# require_relative '../src/style'
# require_relative '../src/util'
# require_relative '../src/widget/col'
# require_relative '../src/widget/button'
# require_relative '../src/widget/row'
# require_relative '../src/widget/label'

# def process_attrs(e)
#   number_attrs = ['width', 'height', 'x', 'y']
#   code_attrs = ['action']
#   a = {}
#   e.attributes.each_attribute do |attr|
#     value = attr.value
#     # p value
#     name =  attr.expanded_name
#     a[name.to_sym] = if number_attrs.include? name
#                 is_percent(value.to_f) ? value.to_f : value.to_i
#               elsif code_attrs.include? name
#                 eval(value)
#               elsif name == 'style'
#                 Style.from_hash(eval(value))
#               else
#                 value.to_s
#               end
#   end
#   # p a
#   a
# end

# def process_node(node, parent = nil)

#   builders = {
#     col: Col,
#     button: Button,
#     label: Label,
#     row: Row
#   }

#   if node.is_a?(REXML::Text)
#     parent.text += node.to_s.strip if parent
#   else
#     # if !builders[node.name.to_sym]
#     #   p 'no found'+node.name+node.class.to_s
#     # end
#     c =  (builders[node.name.to_sym]||Element)
#     # p c.name
#     a = process_attrs(node)    .merge(parent: parent)
#     result = c.new(a)
#     # parent.append_child(result) if parent
#     node.each do |e|
#       cs = process_node(e, result)
#       # c.text = 'asdasd' if c
#       # c.x = 21 if c
#       # result.append_child cs if cs
#     end
#   end
#   result
# end

s = Screen.new
action = proc { s.destroy }
# xml = '
# <row height="0.99" width="0.99" x="10" y="0">

# <col  width="0.5"   style="{bg: :yellow}">

#   <button action="action" style="{bg: :yellow}" >hello</button>
#   <button>sss</button>
#   <button >asdasdasd</button>
#   <label  style="{fg: :yellow}">hehhe</label>
# </col>

# <col width="33" x="0.5"style="{bg: :red}">
#   <button action="action" style="{bg: :yellow}" >hello</button>
#   <button>sss</button>
#   <button x="12">asdasdasd</button>
#   <label  style="{fg: :red}">hehhe</label>
# </col>
# </row>
# '

# <element width="'+s.width.to_s+'" height="'+s.height.to_s+'" x="1" y="1" style="{bg: :yellow}">

# xml = File.open('probes/rexmlProbeTemplate.xml', 'r').read

erb = '
<element width="0.99" height="0.99" x="2" y="2">
<% list.each_with_index {|t, i| %>
  <button y="<%= i*3%>" action="action" x="<%= (i*10+1)/5 %>">hello <%= t %></button>
<% } %>
</element>
'

list = %w[sdf fffff sdf fffff sdf fffff]
# render_erb(template: erb, parent: s, binding: binding)
e = render_erb(template: erb, binding: binding)
s.append_child e

# # p "5".to_f + 1
# doc = REXML::Document.new xml

# s.render
# render_xml(xml: xml, parent: s, binding: binding)
# cc = s.children[0]
# s.remove_child cc
# cc.children.each{|c| c.y=10; c.x=10; s.append_child c}

# s.render
# # r = Row.new(height: 0.99, x: 10, y: 0, width: 0.99, parent:s, ch: 's')
# # s.render
# # p cc
# # cc.each{|c|p c.name+', '+c.get_attribute('x').to_s+', '+c.get_attribute('y').to_s+', '+c.get_attribute('width').to_s+', '+c.get_attribute('height').to_s}
# process_node(doc, s)
# process_node(doc).children.each{|c| s.append_child c}
# s.append_children cc
# p cc[0].children[0].class
# p cc[0].children[0].attributes
# s.append_child Button.new(attributes: {x: 3, y: 5}, text: 'sfsdf')
s.render
s.start
# # puts process_node(doc).pretty_print

# # n = Node.new(name: '1', attributes: {aa: 123}, children: [Node.new(name: '1.1')])
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
