# frozen_string_literal: true

require_relative '../src/renderer'

r = Renderer.new
$stdout.write r.rect(x: 20, y: 10, width: 10, height: 20, ch: 'l')
sleep 1
loop do
  $stdout.write r.write(rand(100), rand(30), ' ')
  $stdout.write r.write(rand(100), rand(30), 'X')
  $stdout.write r.write(rand(100), rand(30), ' ')
  $stdout.write r.write(rand(100), rand(30), 'x')
  $stdout.write r.write(rand(100), rand(30), ' ')
  $stdout.write r.write(rand(100), rand(30), '*')
  $stdout.write r.write(rand(100), rand(30), ' ')
  # sleep 0.0001
end
