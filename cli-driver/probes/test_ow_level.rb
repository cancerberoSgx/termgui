# frozen_string_literal: true

# shows how to use read to control user reading low level
require_relative '../src/cli_driver'
def test(command)
  client = Driver.new
  client.execute(command) # execute won't start listening user input, just run the command.
  running = true
  data = []
  while running
    s = client.read
    if s.nil?
      running = false
      puts 'Process ended, data: \n' + data.join('')
    elsif s != ''
      puts 'data: ' + s
      data.push s
    end
  end
end

test 'ls'
test 'echo 1234'
