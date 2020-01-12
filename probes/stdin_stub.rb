# require 'open3'
# if __FILE__ == $0
#   Open3.popen3("ruby probes/stdin.rb") do |i, o, e, t|
#     i.write "Hello World!"
#     i.close
#     puts o.read
#   end
# end

# print 'please enter it'
s = gets
print s + '!!'
# print 'thanks'
