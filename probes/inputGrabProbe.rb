require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/style'
require_relative '../src/color'

N = 2
screen = Screen.new
screen.event.add_key_listener('q', proc { |_e| screen.destroy })
# previous listener for 'q' won't be notified until ungrab is called
screen.input.grab(proc { |e| screen.text 2, 2, "grab #{e.key}" })
screen.set_timeout(2, proc {
  screen.input.ungrab
  screen.text 2, 2, 'ungrab'
})
screen.start
