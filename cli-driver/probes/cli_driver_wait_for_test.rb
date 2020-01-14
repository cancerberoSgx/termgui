# frozen_string_literal: true

require_relative '../src/cli_driver'

client = Driver.new
s = ''
client.subscribe(:data, proc { |data| s = "DATA #{data}" })
client.subscribe(:quit, proc { |code| puts "EXIT #{code}" })

client.wait_for(
  predicate: proc {
    client.data_str.include? 'enter some text'
  },
  block: proc {
    client.write 'Hello from cli_driver_wait_for_test.rb'
  }
)
client.run 'ruby probes/cli_driver_test_sample.rb'
if s != 'DATA you have entered Hello from cli_driver_wait_for_test.rb !!'
  puts 'ERROR in test, s is ', s
else
  puts 'OK'
end
