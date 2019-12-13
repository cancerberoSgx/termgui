require_relative "../src/renderer"

r = Renderer.new 100, 100
$stdout.write r.rect x: 2, y: 1, width: 8, height: 5, ch: "l"
