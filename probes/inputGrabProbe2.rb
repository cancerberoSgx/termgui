require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/style'
require_relative '../src/color'
require_relative '../src/widget/button'

screen = Screen.new
screen.install_exit_keys
screen.event.add_key_listener('q', proc { |_e| screen.destroy })
grab = screen.append_child Button.new(text: 'grab', x: 12, y: 2, action: proc {
  screen.input.grab(proc { |e| screen.text 2, 2, "grabbed #{e.key}" })
})

# grab = screen.append_child Button.new(text: 'grab') {
#   screen.input.grab(proc { |e| screen.text 2, 2, "grabbed #{e.key}" })
# }
# ungrab = screen.append_child Button.new(text: 'ungrab') {
#   screen.input.ungrab
#   screen.text 2, 2, 'ungrab'
# }
# previous listener for 'q' won't be notified until ungrab is called
# screen.set_timeout(3, proc {
# })
screen.start
