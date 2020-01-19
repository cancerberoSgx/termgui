require_relative '../src/screen'

screen = Screen.new(width: 22, height: 8)
screen.install_exit_keys
screen.event.add_key_listener('h') do |_e|
  screen.cursor_hide
  p 'hiding'
end
screen.event.add_key_listener('s') do |_e|
  screen.cursor_show
  p 'showing'
end
screen.set_timeout(1) do
  screen.cursor_hide
end
screen.set_timeout(2) do
  screen.cursor_show
end
screen.clear
screen.render
screen.start
