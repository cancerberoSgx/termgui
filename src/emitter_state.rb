# adds save/restore event listeners state to Emitter
module EmitterState
  # saves current emitter listeners state under given name
  def emitter_save(name)
    @emitter_state ||= {}
    @emitter_state[name.to_sym] = @events
  end

  # loads a previously saved emitter state with given name.
  # After this call this emitter will notify a different set of listeners
  def emitter_load(name)
    @emitter_state ||= {}
    @events = @emitter_state[name.to_sym] || @events
  end

  def emitter_reset
    @events = {}
  end
end
