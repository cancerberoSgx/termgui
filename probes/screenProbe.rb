require_relative '../src/screen'

s=Screen.new
s.event.addKeyListener('q', Proc.new {|e| puts 'bye'; s.destroy})
t = Thread.new { sleep 1; s.input.write('q')}
t.join
s.start