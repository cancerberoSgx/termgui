# frozen_string_literal: true

require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/event'

class EventManagerTest < Test::Unit::TestCase
  def test_addKeyListener
    e = EventManager.new
    # l = lambda do |e|
    #   print 'called'
    # end
    # e.addKeyListener('q', l)
    s = 'n'
    e.addKeyListener('q', proc do |e|
      s = e.key
    end)
    e.handleKey(KeyEvent.new('q', 'q'))
    assert_equal s, 'q'
  end
end
