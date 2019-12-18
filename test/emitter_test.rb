# frozen_string_literal: true

require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/emitter'
require_relative '../src/util'

class EmitterTest < Test::Unit::TestCase
  def test_event_emitter
    event_emitter = Emitter.new
    s = ''
    ring_bell = lambda do |_object|
      s = 'ring ring ring'
    end
    # create an event 'doorOpen'
    event_emitter.on(:doorOpen)
    # and subscribe code to event
    event_emitter.subscribe(:doorOpen, ring_bell)
    # to trigger event
    event_emitter.emit(:doorOpen)
    next_tick
    assert_equal s, 'ring ring ring'

    s = ''
    event_emitter.subscribe(:doorOpen, proc { |e| s = e[:msg] })
    event_emitter.emit(:doorOpen, msg: 'hello')
    next_tick
    assert_equal s, 'hello'
  end
end
