# frozen_string_literal: true

require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/cli_driver'

# execute() and very first low level tests
class LowLevelTest < Test::Unit::TestCase
  def test_execute
    client = Driver.new
    # execute won't start listening user input, just run the command.
    client.execute("node -e 'process.stdout.write((3.13+0.02).toString())'")
    running = true
    data = []
    while running
      s = client.read
      if s.nil?
        running = false
      elsif s != ''
        data.push s
      end
    end
    assert_equal data.join('').strip, '3.15'
  end
end
