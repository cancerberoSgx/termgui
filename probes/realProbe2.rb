require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/element'
require_relative '../src/style'
require_relative '../src/color'
require_relative '../src/log'
require_relative '../src/widget/col'
require_relative '../src/widget/row'
require_relative '../src/widget/button'
require_relative '../src/widget/label'

screen = Screen.new
screen.input.install_exit_keys

left = Col.new(width: 0.4, height: 0.99, style: { bg: 'red' })
left_labels = (0..8).map { |i| left.append_child Label.new(text: "Label_#{i}") }
right = Col.new(width: 0.6, height: 0.99, x: 0.4, style: Style.new(bg: 'blue'))
right_buttons = (0..4).map { |i| right.append_child Button.new(text: "Button_#{i}", x: 0.5) }
[left, right].each { |widget| screen.append_child widget }

b1 = screen.append_child Button.new(text: 'hello', y: 0.6, x: 0.4, attributes: { focusable: true })
b2 = screen.append_child Button.new(text: 'world', y: 0.8, x: 0.2, attributes: { focusable: true })

b1.on(:action){log 'action'}

# p right_buttons[0].style
screen.focus.subscribe(:focus, proc { |e|
  e[:focused]&.style&.bg= 'white'
  e[:previous]&.style&.bg= 'black'
  screen.render e[:focused]
  screen.render e[:previous]
  # log 'focused'
})

screen.clear
# screen.rect(x: 0,y: 0,width: 4,height: 4,ch: 'x')
screen.render
# screen.renderer.print_dev_stdout

screen.start