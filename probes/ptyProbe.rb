require "pty"

master, slave = PTY.open
read, write = IO.pipe
pid = spawn("ruby probes/ptyProbeTest.rb", :in => read, :out => slave)
read.close     # we dont need the read
slave.close    # or the slave

write.puts "42"
output = master.gets
if output.include? "you have entered 42 !!"
  print "OK"
else
  throw 'expected to include "you have entered 42 !!"'
end
write.close # close the pipe

def read
  # The result of read operation when pty slave is closed is platform
  # dependent.
  begin
    master.gets     # FreeBSD returns nil.
  rescue Errno::EIO # GNU/Linux raises EIO.
    nil
  end
end

puts "\nret: #{ret == nil ? 0 : ret}" #=> nil
