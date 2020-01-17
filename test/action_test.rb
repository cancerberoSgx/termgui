require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/element'
require_relative '../src/screen'
require_relative '../src/log'

class ActionTest < Test::Unit::TestCase
  def test_global_action
    screen = Screen.new width: 5, height: 6
    s = ''
    global = ''
    e1 = screen.append_child Element.new(text: '1', attributes: { focusable: true })
    screen.append_child Element.new(text: '2', attributes: { focusable: true, action: proc { |_e| s = 'e2' } })
    e1.set_attribute('action', proc { s = 'e1' })
    screen.action.on('action') do |e|
      global = 'e' + e.target.text
    end
    screen.input.emit_key 'enter'
    assert_equal '', s
    assert_equal '', global
    screen.focus.focus_next
    assert_equal '', s
    assert_equal '', global
    screen.input.emit_key 'enter'
    assert_equal 'e2', s
    assert_equal 'e2', global
    screen.focus.focus_next
    assert_equal 'e2', s
    assert_equal 'e2', global
    screen.input.emit_key 'enter'
    assert_equal 'e1', s
    assert_equal 'e1', global
  end
end
