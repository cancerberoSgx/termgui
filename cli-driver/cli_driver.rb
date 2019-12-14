require "timeout"
require "pty"
require_relative "../src/emitter"

# spawn given command using pty. This gives access both to command´s stdin and stdout.
# How this works is looping until the process ends, reading stdout and notifying on each iteration.
# a simple timer is supported so operations like setTimeout or waitUntil are supported
# users can register for new stdout data (to assert against)
# users can simulate keypress events
# be notified when stdout matches something
# This is the base class that is extended for adding more high level APIs
class Driver < Emitter
  def initialize(interval: 0.1)
    @data = []
    @interval = 0.1
    @running = false
    @time = Time.now
    @timeout_listeners = []
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

  def setTimeout(seconds, block)
    listener = { seconds: seconds, block: block, time: @time, target: @time + seconds }
    @timeout_listeners.push listener
  end

  def event_loop
    while @running
      # t = Time.now
      data = ""
      begin
        status = Timeout::timeout(@interval) {
          # p "before"
          data = read
          # p "after"
        }
      rescue => e
        # block.call
      else
        # block.call
        # print 'x.raise exception, message'
        # x.raise exception, message
      end
      # # _set_timeout(@interval, Proc.new {
      # })
      # p @time, data
      if data == nil
        @running = false
        emit :quit, 0 # TODO: exit code
      elsif data!=''
        @data.push data
        emit :data, data
      else
      end
      @time = Time.now
      dispatch_set_timeout
    end
  end

  def dispatch_set_timeout
    # p 'dispatch_set_timeout',  @timeout_listeners
    @timeout_listeners.each do |listener|
      # p listener[:target] , @time,
      if listener[:target] < @time
        listener[:block] .call
        @timeout_listeners.delete listener
      else
      end
    end
  end

  # def _set_timeout(sec, block)
  #   begin
  #     status = Timeout::timeout(sec) {
  #       sleep 999999
  #       # print 'takes too long'
  #     }
  #   rescue => e
  #     block.call
  #     # print 'x.raise e'
  #   else
  #     block.call
  #     # print 'x.raise exception, message'
  #     # x.raise exception, message
  #   end
  # end

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
    else
      p "ERRRR"
    end
  end
end

client = Driver.new
client.subscribe :data, Proc.new { |data| print "DATA #{data}" }
client.subscribe :quit, Proc.new { |code| print "EXIT #{code}" }
# client.run "ls"
client.setTimeout(3, Proc.new {
  p "timeout"
  exit
})
client.run "cat"
# client.run ""
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
