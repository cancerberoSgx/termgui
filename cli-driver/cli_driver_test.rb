require_relative "cli_driver"

client = Driver.new
s=''
client.subscribe :data, Proc.new { |data| s = "DATA #{data}" }
client.subscribe :quit, Proc.new { |code| puts "EXIT #{code}" }

client.set_timeout 1, Proc.new {
  client.write("Hello world")
}
client.run "ruby cli-driver/cli_driver_test_sample.rb"
if s!='DATA you have entered Hello world !!'
  puts 'ERROR in test, s is ', s
else
  puts 'OK'
end

# client.set_timeout(3, Proc.new {
#   p "timeout"
#   exit
# })
# client.run "cat"


# TAB = "\u0009".encode("utf-8")
# RETURN = "\r".encode("utf-8")
# backspace = "\x08".encode("utf-8") # 0x7f
# ESCAPE = "\u001b".encode("utf-8")
# checkmark = "\u2713"
# puts checkmark.encode("utf-8")
# puts ESCAPE.encode("utf-8")
# puts TAB.encode("utf-8")
# puts RETURN.encode("utf-8")
# p "end"
# # p TAB, ESCAPE , backspace

# "p.txt [New File]"
