# frozen_string_literal: true

x = 1
t = Thread.new { sleep 1; puts 't ' + x.to_s; x += 1 }
sleep 2
puts 'hello' + x.to_s
t.join
