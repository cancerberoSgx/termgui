require_relative "time_driver"

class WaitDriver < TimeDriver
  def initialize
    super
    @waitTimeout = 5
    @waitInterval = 0.3
  end

  def waitFor(predicate: nil, timeout: 5, interval: 0.1)
    throw "todo"
  end
end
