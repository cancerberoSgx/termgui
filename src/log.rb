
# Adds logging to file and screen capabilities
module Log
  def log_file=(file)
    @file = file
  end

  def log(*args)
    file = @file || 'tmp_log.txt'
    s = args.nil? ? 'nil' : args.to_s
    s = "------\n#{s}\n"
    File.open(file, 'a') { |f| f.puts s }
  end

end

# default logger class
class DefaultLogger
  include Log
end

DEFAULT_LOGGER = DefaultLogger.new

def log(*args)
  DEFAULT_LOGGER.log *args
end
