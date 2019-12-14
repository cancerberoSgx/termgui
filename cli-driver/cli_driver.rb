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
    on(:interval)
  end

  def execute(command)
    @master, @slave = PTY.open
    @read, @write = IO.pipe
    @pid = spawn(command, :in => @read, :out => @slave)
    @read.close     # we dont need the read
    @slave.close    # or the slave
    @running = true
  end

  # calls `execute` and starts listening user input
  def run(command)
    execute command
    listen_user
  end

  # register a timeout listener that will be called in given seconds (aprox). 
  # Returns a listener object that can be used with clear_timeout to remove the listener
  def set_timeout(seconds, block)
    listener = { seconds: seconds, block: block, time: @time, target: @time + seconds }
    @timeout_listeners.push listener
    listener
  end

  def clear_timeout(listener)
    @timeout_listeners.delete listener
  end

  def write(s)
    @master.puts s
  end

  def listen_user
    while @running
      data = ""
      begin
        status = Timeout::timeout(@interval) {
          data = read
        }
      rescue => e
      else
      end
      if data == nil # program exited
        @running = false
        emit :quit, 0 # TODO: exit code
      elsif data != "" 
        @data.push data
        emit :data, data
      else
      end
      @time = Time.now
      dispatch_set_timeout
      emit :interval
    end
  end

  # Native IO::read operation, will block. To consume stdout use `data`, `wait_data`, etc instead of this method. 
  # if returns `nil` it means the process has ended
  def read
    if !@master
      throw '"read" called before "execute"'
    end
    # The result of read operation when pty slave is closed is platform dependent.
    begin
      @master.gets     # FreeBSD returns nil.
    rescue Errno::EIO # GNU/Linux raises EIO.
      nil
    end
  end

  protected

  def dispatch_set_timeout
    @timeout_listeners.each do |listener|
      if listener[:target] < @time
        listener[:block].call
        @timeout_listeners.delete listener
      else
      end
    end
  end

end
