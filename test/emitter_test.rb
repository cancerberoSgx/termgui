require "test/unit"
include Test::Unit::Assertions
require_relative "../src/emitter"
require_relative "../src/util"

class EmitterTest < Test::Unit::TestCase
  def test_children
    event_emitter = Emitter.new
    s = ""
    ring_bell = lambda do |object|
      s = "ring ring ring"
    end
    # create an event 'doorOpen'
    event_emitter.on(:doorOpen)
    # and subscribe code to event
    event_emitter.subscribe(:doorOpen, ring_bell)
    # to trigger event
    event_emitter.emit(:doorOpen)
    nextTick
    assert_equal s, "ring ring ring"

    s = ""
    event_emitter.subscribe(:doorOpen, Proc.new { |e| s = e[:msg] })
    event_emitter.emit(:doorOpen, { msg: "hello" })
    nextTick
    assert_equal s, "hello"
  end
end
