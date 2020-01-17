require_relative '../src/element'
require_relative '../src/screen'

s = Screen.new width: 5, height: 6
e1 = s.append_child Element.new(text: '1', attributes: { focusable: true })
e2 = s.append_child Element.new(text: '2', attributes: { focusable: true, action: proc { |_e| p 'e2' } })
s.action.on('action') do |_e|
  p 'e1'
end
s.input.emit_key 'enter'
s.focus.focus_next
s.input.emit_key 'enter'
