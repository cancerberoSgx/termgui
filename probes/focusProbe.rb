require_relative '../src/screen'
require_relative '../src/element'

s = Screen.new
s.input.install_exit_keys
s.append_child Element.new(x: 2, y: 3, width: 8, height: 3, ch: 'e', attributes: { focusable: true })
s.append_child Element.new(x: 12, y: 6, width: 8, height: 4, ch: 'e', attributes: { focusable: true })
s.append_child Element.new(x: 21, y: 3, width: 8, height: 5, ch: 'e', attributes: { focusable: true })
s.focus.subscribe :focus, proc { |e|
  e[:focused].set_attribute('ch', 'F')
  e[:previous]&.set_attribute('ch', 'e')
  s.render
}
s.clear
s.render
s.start
