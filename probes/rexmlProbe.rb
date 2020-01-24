require '/Users/wyeworks/.rubies/ruby-2.6.5/lib/ruby/2.6.0/rexml/document'
require_relative '../src/Node'

xml = '
<col width="0.8">
<button action="proc {|e| p 123}">hello</button>
</col>
'

def process_attrs(e)
  number_attrs = ['width']
  code_attrs = ['action']
  a = {}
  e.attributes.each_attribute do |attr|
    value = attr.value
    name =  attr.expanded_name
    a[name] = if number_attrs.include? name
                value.to_f
              elsif code_attrs.include? name
                eval(value)
              else
                value
              end
  end
  a
end

# {}.respond_to? :name
# eval()
def process_node(node)
  return { text: node } if node.is_a? REXML::Text
  result = { name: node.name, attrs: process_attrs(node), children: [] }
  node.each do |e|
    result[:children].push process_node(e)
  end
  result
end
doc = REXML::Document.new xml

p process_node(doc)

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

# builders = {
#   col: proc {|node|
#   Col.new(process_attrs(node.attributes))
#   # node.chil
# }
# }