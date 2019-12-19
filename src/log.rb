# Adds logging to file capabilities
module Log
  def log_file=(file)
    @file = file
  end

  def log(arg, title = nil)
    file = @file || 'tmp_log.txt'
    s = arg.nil? ? 'nil' : arg.to_s
    s = "------\n#{title ? title + '\n' : ''}#{s}\n"
    File.open(file, 'w') { |f| f.puts s }
  end
end

# default logger class
class DefaultLogger
  include Log
end

DEFAULT_LOGGER = DefaultLogger.new

def log(arg, title = nil)
  DEFAULT_LOGGER.log arg, title
end
