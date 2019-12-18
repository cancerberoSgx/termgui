# frozen_string_literal: true

require 'open3'
# if __FILE__ == $0
Open3.popen3('ruby probes/stdin_stub.rb') do |i, o, _e, _t|
  i.write 'Hello World!'
  i.close
  puts "**#{o.read}**"
end
# end
