# require 'test/unit'
# include Test::Unit::Assertions
# require_relative '../src/xml/xml'

# class XmlTest < Test::Unit::TestCase
#   def test_render_xml
#     aaaa = 0
#     xml = '
# <element>
#   <button action="proc { aaaa=33}" style="{bg: :yellow}" x="11" y="5" height="3" width="12">hello</button>
#   <label x="12" y="3" height="3" width="12">hehhe</label>
# </element>
# '
#     s = Screen.new_for_testing(width: 33, height: 12)
#     render_xml(xml: xml, parent: s, binding: binding)
#     s.render

#     assert_equal '                                 \n' \
#                  '                                 \n' \
#                  '                                 \n' \
#                  '            hehhe                \n' \
#                  '          ┌─────┐                \n' \
#                  '          │hello│                \n' \
#                  '          └─────┘                \n' \
#                  '                                 \n' \
#                  '                                 \n' \
#                  '                                 \n' \
#                  '                                 \n' \
#                  '                                 \n', s.renderer.print

#     s.query_by_name('button')[0].set_attribute('focused', true)
#     s.set_timeout  do
#       assert_equal 0, aaaa
#       s.event.handle_key(KeyEvent.new('enter'))
#       s.destroy
#     end
#     s.start
#     assert_equal 33, aaaa
#   end

#   def test_render_erb
#     aaaa = 0
#     s = Screen.new_for_testing(width: 33, height: 13)
#     erb = '
# <element width="0.99" height="0.99" x="2" y="2">
# <% list.each_with_index {|t, i| %>
#   <button action="proc { aaaa=33}" y="<%= i*3%>">hello <%= t %></button>
# <% } %>
# </element>
# '
#     list = %w[sdf fffff sdf]
#     render_erb(template: erb, parent: s, binding: binding, erb_binding: binding)
#     s.query_by_name('button')[0].set_attribute('focused', true)
#     s.set_timeout  do
#       assert_equal 0, aaaa
#       s.event.handle_key(KeyEvent.new('enter'))
#       s.destroy
#     end
#     s.render
#     assert_equal '                                 \n' \
#                  ' ┌─────────┐                     \n' \
#                  ' │hello sdf│                     \n' \
#                  ' └─────────┘                     \n' \
#                  ' ┌───────────┐                   \n' \
#                  ' │hello fffff│                   \n' \
#                  ' └───────────┘                   \n' \
#                  ' ┌─────────┐                     \n' \
#                  ' │hello sdf│                     \n' \
#                  ' └─────────┘                     \n' \
#                  '                                 \n' \
#                  '                                 \n' \
#                  '                                 \n', s.print
#     # s.renderer.print_dev_stdout
#     s.start
#     assert_equal 33, aaaa
#   end
# end
