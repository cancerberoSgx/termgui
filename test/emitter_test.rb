require "test/unit"
include Test::Unit::Assertions
require_relative '../src/emitter'

class EmitterTest < Test::Unit::TestCase
  def test_children
    event_emitter = Emitter.new
    s=''
    ring_bell = lambda do |event_name, object|
      s= 'ring ring ring'
    end
    # create an event 'doorOpen'
    event_emitter.on(:doorOpen)
    # and subscribe code to event
    event_emitter.subscribe(:doorOpen, ring_bell)
    # to trigger event
    event_emitter.emit(:doorOpen)
    sleep 0.1
    assert_equal s, 'ring ring ring'
  end  
end
 