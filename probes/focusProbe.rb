require_relative "../src/screen"
require_relative "../src/element"

s = Screen.new
s.input.install_exit_keys
# n1 = Element.new(attributes: {focusable: true, ch: '1', fg: 'red', x: 2, y: 1, width: 6, height: 3})
s.append_child Element.new(x: 2, y: 3, width: 8, height: 3, ch: "e", attributes: {focusable: true})
s.append_child Element.new(x: 12, y: 6, width: 8, height: 3, ch: "e", attributes: {focusable: true})
# draw = Proc.new { |e|
#   s.clear
#   s.render
# }
s.focus.subscribe :focus, Proc.new {|e|
  e[:focused].set_attribute('ch', 'F')
  e[:previous].set_attribute('ch', 'e') if e[:previous]
  # s.clear
  s.render
}
# s.event.addKeyListener("s", draw)
# print "press q to exit and 's' to render"
s.clear
s.render
s.start
