require_relative '../src/renderer'

r=Renderer.new
$stdout.write r.rect(20,10,10,20, 'l')
sleep 1
while true do
  $stdout.write r.write(rand(100), rand(30), ' ')
  $stdout.write r.write(rand(100), rand(30), 'X')
  $stdout.write r.write(rand(100), rand(30), ' ')
  $stdout.write r.write(rand(100), rand(30), 'x')
  $stdout.write r.write(rand(100), rand(30), ' ')
  $stdout.write r.write(rand(100), rand(30), '*')
  $stdout.write r.write(rand(100), rand(30), ' ')
  # sleep 0.0001
end
