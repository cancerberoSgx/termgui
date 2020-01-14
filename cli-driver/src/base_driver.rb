# frozen_string_literal: true

require 'timeout'
require 'pty'
require_relative '../../src/emitter'

# spawn given command using pty. This gives access both to command's stdin and stdout.
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
    install(:quit)
    install(:data)
    install(:interval)
  end

  # execute won't start listening user input, just run the command. Non blocking operation
  def execute(command)
    @master, @slave = PTY.open
    @read, @write = IO.pipe
    @pid = spawn(command, in: @read, out: @slave)
    @read.close     # we dont need the read
    @slave.close    # or the slave
    @running = true
  end

  # closes @master and forces the event loop to stop
  def destroy
    @master&.close
    @running = false
  end

  # calls `execute` and starts listening user input
  def run(command)
    execute command
    listen_user
  end

  def write(s)
    @write.puts s
  end

  attr_reader :data

  def data_str
    # TODO: maintain @data_str copy for performance
    @data.join('').strip
  end

  attr_writer :interval

  # Starts an event loop reading from @master and setting a timeout to @interval to interrupt the read call.
  # This operation blocks until destroy() is called.
  def listen_user
    while @running
      data = ''
      begin
        Timeout.timeout(@interval) do
          data = read
        end
        # p 'status', status
      rescue StandardError
      else
      end
      if data.nil? # program exited
        @running = false
        emit :quit, 0 # TODO: exit code
      elsif data != ''
        @data.push data
        emit :data, data
      end
      after_user_input
    end
  end

  # Native IO::read operation, will block. To consume stdout use `data`, `wait_data`, etc instead of this method.
  # if returns `nil` it means the process has ended
  def read
    throw '"read" called before "execute"' unless @master
    # The result of read operation when pty slave is closed is platform dependent.
    begin
      @master.gets # FreeBSD returns nil.
    rescue Errno::EIO # GNU/Linux raises EIO.
      nil
    end
  end

  protected

  def after_user_input
    emit :interval
  end
end
