require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/termgui'

class TermGuiTest < Test::Unit::TestCase
  def test_termgui
    el = TermGui::Element.new(text: 'hello')
    assert_equal 'hello', el.text
  end
end
