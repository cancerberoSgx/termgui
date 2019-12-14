require_relative 'cli_driver'

client = Driver.new
client.subscribe :data, Proc.new { |data| print "DATA #{data}" }
client.subscribe :quit, Proc.new { |code| print "EXIT #{code}" }
client.setTimeout(3, Proc.new {
  p "timeout"
  exit
})
client.run "cat"