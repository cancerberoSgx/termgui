require_relative '../src/renderer'

r=Renderer.new
r.style = Style.new(bg: 'yellow', fg: 'red')
$stdout.write r.rect(x: 20, y: 10, width: 10, height: 20, ch: 'l')