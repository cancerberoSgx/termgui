require_relative '../src/input'

i = Input.new
i.subscribe('key', proc do |e|
  $stdout.write e.key.to_s
  p e
  exit if e.key == 'q'
end)
i.start
