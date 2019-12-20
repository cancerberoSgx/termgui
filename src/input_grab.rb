require_relative 'util'

# Add Input support for grab, this is stop notifying listeners and notify others. Based on EmitterState
module InputGrab
  def grab(block)
    emitter_save('grab')
    emitter_reset
    install(:key)
    subscribe(:key, block)
  end

  def ungrab
    emitter_load('grab')
  end
end
