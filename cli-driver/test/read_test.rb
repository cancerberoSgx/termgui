require "test/unit"
include Test::Unit::Assertions
require_relative "../src/cli_driver"

class LowLevelTest < Test::Unit::TestCase
  def test_low_level_read
    client = Driver.new
    client.execute("node -e 'process.stdout.write((3.13+0.02).toString())'") # execute won't start listening user input, just run the command.
    running = true
    data = []
    while running
      s = client.read
      if s == nil
        running = false
        # puts 'Process ended, data: \n' + data.join("")
      elsif s != ""
        # puts "data: " + s
        data.push s
      end
    end
    assert_equal data.join('').strip, '3.15'
    # if data.join('').strip!='3.15'
    #   puts 'Test error, s: '+s
    # else
    #   puts 'test OK'
    # end
  end
end
