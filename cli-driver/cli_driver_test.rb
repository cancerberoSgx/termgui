require_relative "cli_driver"

client = Driver.new

client.subscribe :data, Proc.new { |data| print "DATA #{data}" }
client.subscribe :quit, Proc.new { |code| print "EXIT #{code}" }

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

client.set_timeout(1, Proc.new {
  client.write(ESCAPE)
  client.write(":h")
})
client.run "vim p.txt"
