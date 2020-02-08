require_relative '../src/screen'

screen = Screen.new

screen.set_timeout do
  screen.clear
  t0 = Time.now
  screen.renderer.fast_colouring = true
  screen.image(x: 10, y: 5, image: 'probes/assets/apples.png')
  # screen.input.tick
  screen.text(text: Time.now - t0); t0 = Time.now
  screen.image(x: 40, y: 33, image: 'probes/assets/brazil.png')
  screen.text(text: Time.now - t0, y: 1); t0 = Time.now
  screen.image(x: 100, y: 55, image: 'probes/assets/sample.png', double_cols: true)
  screen.text(text: Time.now - t0, y: 2); t0 = Time.now
end

screen.start
# p Time.now - t0
# sleep 5
