require_relative 'util'

# Add Input support for grab, this is stop notifying listeners and notify others. Based on EmitterState
module InputGrab
  def grab(block = nil, &b)
    the_block = block == nil ? b : block
    throw 'Block not given' unless the_block
    emitter_save('grab')
    emitter_reset
    install(:key)
    subscribe(:key, the_block)
  end

  def ungrab
    emitter_load('grab')
  end
end
