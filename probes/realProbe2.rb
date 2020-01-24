require_relative '../src/screen'
require_relative '../src/style'
require_relative '../src/widget/col'
require_relative '../src/widget/row'
require_relative '../src/widget/modal'
require_relative '../src/widget/button'
require_relative '../src/widget/label'

screen = Screen.new
screen.install_exit_keys

left = Col.new(width: 0.4, height: 0.99, style: { bg: 'red' })
(0..8).map { |i| left.append_child Label.new(text: "Label_#{i}") }
right = Col.new(width: 0.6, height: 0.99, x: 0.4, style: Style.new(bg: 'blue'))
(0..4).map do |i|
  b = right.append_child Button.new(
    text: "Button_#{i}", x: 0.5,
    action: proc { open_modal(screen: screen, title: "Button_#{i}") }
  )
end
[left, right].each { |widget| screen.append_child widget }

b1 = screen.append_child Button.new(text: 'hello', y: 0.6, x: 0.4, action: proc {
  open_modal(screen: screen, title: 'button 1')
})

left.append_child(Element.new(text: 'should inherith style', x: 0.3, y: 0.6, width: 18, height: 5, style: Style.new(fg: 'blue')))
left.append_child(Element.new(text: 'other', x: 0.1, y: 0.5, width: 8, height: 2, style: { fg: 'yellow', bold: true, underline: true }, attributes: { 'style-cascade': 'prevent' }))

left.append_child(Element.new(text: 'should not \ninherit style', x: 0.3, y: 0.8, width: 18, height: 5, style: { fg: 'magenta', blink: true }, attributes: { 'style-cascade': 'prevent' }))

b2 = screen.append_child Button.new(text: 'world ' + screen.query_by_attribute('focusable', true).length.to_s, y: 0.8, x: 0.2)
b2.set_attribute('action', proc {
  open_modal(screen: screen, title: 'button 2')
})

screen.start
