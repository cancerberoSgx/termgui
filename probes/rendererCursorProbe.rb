require_relative '../src/screen'

screen = Screen.new(width: 22, height: 8)
screen.input.install_exit_keys
screen.event.add_key_listener('e') { |e|
  p 'hello'
}
screen.set_timeout(1) {
  
}
screen.clear
screen.render
screen.start
# screen.cursor_move(8, 2)
