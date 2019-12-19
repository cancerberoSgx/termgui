# Adds logging to file capabilities
module Log
  def log_file=(file)
    @file = file
  end

  def log(arg, title = nil)
    s = arg.nil? ? 'nil' : arg.to_s
    s = "------\n#{title ? title + '\n' : ''}#{s}\n"
    File.open(@file, 'w') { |f| f.puts s }
  end
end
