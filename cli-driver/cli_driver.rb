require "pty"
require_relative "../src/emitter"

class Driver < Emitter
  def initialize
    @data = []
    @interval = 0.1
    @running = false
    on(:quit)
    on(:data)
  end

  def run(command)
    @master, @slave = PTY.open
    @read, @write = IO.pipe
    @pid = spawn(command, :in => @read, :out => @slave)
    @read.close     # we dont need the read
    @slave.close    # or the slave
    @running = true
    event_loop
  end

  def event_loop
    while @running
      data = read
      if data == nil
        @running = false
        emit :quit, 0 # TODO: exit code
      elsif data
        @data.push data
        emit :data, data
      else
      end
    end
  end

  def write(s)
    write.puts s
  end

  # if returns nil it means the process has ended
  def read
    # The result of read operation when pty slave is closed is platform dependent.
    begin
      @master.gets     # FreeBSD returns nil.
    rescue Errno::EIO # GNU/Linux raises EIO.
      nil
    end
  end
end

client = Driver.new
client.subscribe :data, Proc.new {|data| print "DATA #{data}"}
client.subscribe :quit, Proc.new {|code| print "EXIT #{code}"}
client.run "ls"
# print "**#{client.read}**"
# print "**#{client.read}**"
# print "**#{client.read}**"
# master, slave = PTY.open
# read, write = IO.pipe
# pid = spawn("ruby probes/ptyProbeTest.rb", :in => read, :out => slave)
# read.close     # we dont need the read
# slave.close    # or the slave

# write.puts "42"
# output = master.gets
# if output.include? "you have entered 42 !!"
#   print "OK"
# else
#   throw 'expected to include "you have entered 42 !!"'
# end
# write.close # close the pipe

# def read
#   # The result of read operation when pty slave is closed is platform
#   # dependent.
#   begin
#     master.gets     # FreeBSD returns nil.
#   rescue Errno::EIO # GNU/Linux raises EIO.
#     nil
#   end
# end

# puts "\nret: #{ret == nil ? 0 : ret}" #=> nil
