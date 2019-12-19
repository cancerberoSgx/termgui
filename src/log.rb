# Adds logging to file capabilities
module Log
  def initialize(file = 'log.txt')
    @file = file
    @name = name
  end

  def log_object(arg)
    s = arg.nil? ? 'nil' : arg.to_s
    s = "\n\n------\n#{s}\n"
    File.open(@file, 'w') { |f| f.puts s }
  end
end
