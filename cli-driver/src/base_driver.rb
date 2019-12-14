require "timeout"
require "pty"
require_relative "../../src/emitter"

# spawn given command using pty. This gives access both to command´s stdin and stdout.
# How this works is looping until the process ends, reading stdout and notifying on each iteration.
# a simple timer is supported so operations like set_timeout or wait_until are supported (See TimeDriver and WaitDriver)
# users can register for new stdout data (to assert against)
# users can simulate keypress events
# be notified when stdout matches something
# This is the base class that is extended for adding more high level APIs
class BaseDriver < Emitter
  def initialize
    super
    @data = []
    @interval = 0.1
    @running = false
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

  # def destroy
  # @master.close if @master
  # end

  # calls `execute` and starts listening user input
  def run(command)
    execute command
    listen_user
  end

  def write(s)
    @write.puts s
  end

  def data
    @data
  end

  def interval=(interval)
    @interval = interval
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
      after_user_input
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

  def after_user_input
    emit :interval
  end
end
