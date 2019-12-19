
require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/event'

class EventManagerTest < Test::Unit::TestCase
  def test_add_key_listener
    e = EventManager.new
    s = 'n'
    e.add_key_listener('q', proc do |ev|
      s = ev.key
    end)

    e.handle_key(KeyEvent.new('q', 'q'))
    assert_equal s, 'q', 'should notify'

    e.handle_key(KeyEvent.new('x', 'x'))
    assert_equal s, 'q', 'should not notify'
  end
end
