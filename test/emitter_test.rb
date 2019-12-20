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
    event_emitter.install(:doorOpen)
    # and subscribe code to event
    event_emitter.subscribe(:doorOpen, ring_bell)
    # to trigger event
    event_emitter.emit(:doorOpen)
    next_tick
    assert_equal 'ring ring ring', s

    s = ''
    event_emitter.subscribe(:doorOpen, proc { |e| s = e[:msg] })
    event_emitter.emit(:doorOpen, msg: 'hello')
    next_tick
    assert_equal 'hello', s
  end

  def test_state
    e = Emitter.new
    e.install(:play)
    a = 0
    b = 0
    e.subscribe(:play, proc {
      a += 1
      p 'kjashdkjahsd'
    })
    e.emit(:play)
    assert_equal 1, a
    assert_equal 0, b
    e.emitter_save('a')
    e.emitter_reset
    e.install(:play)
    e.on(:play, proc { b += 1 })
    e.emit(:play)
    assert_equal 1, a
    assert_equal 1, b
    e.emitter_save('b')

    e.emitter_load('a')
    e.emit(:play)
    assert_equal 2, a
    assert_equal 1, b

    e.emitter_load('b')
    e.emit(:play)
    assert_equal 2, a
    assert_equal 2, b
  end
end
