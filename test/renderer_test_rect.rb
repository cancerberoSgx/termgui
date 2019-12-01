require_relative '../src/renderer'

  r=Renderer.new 100, 100 
  $stdout.write r.rect(2,1,8,5, 'l')

 