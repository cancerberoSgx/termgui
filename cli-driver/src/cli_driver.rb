require_relative "base_driver"

class WaitDriver < BaseDriver
  def initialize
    super
    @waitTimeout=5
    @waitInterval=0.3
  end
  def waitFor(predicate: nil, timeout: 5, interval: 0.1)
    throw 'todo'
  end
end


class Driver < WaitDriver
end
