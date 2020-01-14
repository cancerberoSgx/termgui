require_relative '../src/screen'
require_relative '../src/style'
require_relative '../src/widget/col'
require_relative '../src/widget/row'
require_relative '../src/widget/modal'
require_relative '../src/widget/button'
require_relative '../src/widget/label'

screen = Screen.new
screen.event.add_any_key_listener do |e|
  print e.key
  screen.destroy if e.key == 'q'
end

screen.start
