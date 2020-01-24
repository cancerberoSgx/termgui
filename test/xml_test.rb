require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/xml/xml'

class XmlTest < Test::Unit::TestCase
  def test_1
    aaaa = 0
    xml = '
<element>
  <button action="proc { aaaa=33}" style="{bg: :yellow}" x="11" y="5" height="3" width="12">hello</button>
  <label x="12" y="3" height="3" width="12">hehhe</label>
</element>
'
    s = Screen.new_for_testing(width: 33, height: 12)
    render_xml(xml: xml, parent: s, binding: binding)
    s.render

    assert_equal '                                 \n' \
                 '                                 \n' \
                 '                                 \n' \
                 '            hehhe                \n' \
                 '          ┌─────┐                \n' \
                 '          │hello│                \n' \
                 '          └─────┘                \n' \
                 '                                 \n' \
                 '                                 \n' \
                 '                                 \n' \
                 '                                 \n' \
                 '                                 \n', s.renderer.print

    s.query_by_name('button')[0].set_attribute('focused', true)
    s.set_timeout  do
      assert_equal 0, aaaa
      s.event.handle_key(KeyEvent.new('enter'))
      s.destroy
    end
    s.start
    assert_equal 33, aaaa
  end
end
