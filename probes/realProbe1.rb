require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/element'
require_relative '../src/style'
require_relative '../src/color'
require_relative '../src/widget/col'
require_relative '../src/widget/row'
require_relative '../src/widget/button'
require_relative '../src/widget/label'

screen = Screen.new(width: 70, height: 18)
screen.install_exit_keys

# col = screen.append_child Col.new(x: 1, y: 1)
# col.append_child Button.new(text: 'hello', style: { bg: 'blue'}, action: proc { p 'hello!' })
# col.append_child Button.new(text: 'world', action: proc { |e| p "#{e.target.text} clicked!" })

# l1 = Button.new(text: 'label1')
# l2 = Button.new(text: 'label2')
# l3 = Button.new(text: 'label3')
# c = Col.new(children: [l1, l2, l3], y: 3, x: 2)
# screen.append_child c
# screen.silent = true
# screen.clear
# screen.render
# screen.renderer.print_dev_stdout
# # screen.start

# e = Element.new x: 0.15, y: 0.2, width: 0.3, height: 0.5, ch: ' ',
#                 text: 'Hello long long wraped text let get bigger and bigger',
#                 style: { bg: 'blue', fg: 'yellow', wrap: true,
#                          border: Border.new(style: :double),
#                          padding: Offset.new(top: 0.5, left: 0.4) }
# screen.append_child(e)
# screen.clear
# screen.render
# screen.start

#  y: 2, x: 2,
#  x: 20, y: 4,
# screen.silent=true

left = Col.new(width: 0.4, height: 0.99, style: { bg: 'red' })
left_labels = (0..8).map { |i| left.append_child Label.new(text: "Label_#{i}") }
right = Col.new(width: 0.6, height: 0.99, x: 0.4, style: Style.new(bg: 'blue'))
right_buttons = (0..4).map { |i| right.append_child Button.new(text: "Button_#{i}") }

[left, right].each { |widget| screen.append_child widget }
screen.clear
screen.render
# screen.renderer.print_dev_stdout
# expected = '' \
#   'Label_0                                            ┌────────┐                                                                     \n' \
#   'Label_1                                            │Button_0│                                                                     \n' \
#   'Label_2                                            └────────┘                                                                     \n' \
#   'Label_3                                            ┌────────┐                                                                     \n' \
#   'Label_4                                            │Button_1│                                                                     \n' \
#   'Label_5                                            └────────┘                                                                     \n' \
#   'Label_6                                            ┌────────┐                                                                     \n' \
#   'Label_7                                            │Button_2│                                                                     \n' \
#   'Label_8                                            └────────┘                                                                     \n' \
#   '                                                   ┌────────┐                                                                     \n' \
#   '                                                   │Button_3│                                                                     \n' \
#   '                                                   └────────┘                                                                     \n' \
#   '                                                   ┌────────┐                                                                     \n' \
#   '                                                   │Button_4│                                                                     \n' \
#   ''
screen.start
p ' print_dev_stdout '
p ' print_dev_stdout '
p ' print_dev_stdout '
screen.renderer.print_dev_stdout
log('*' + screen.print + '*')

# right_rows = (0..2).map{|i|
#   row = Row.new(height: 0.4)
#   # button = row.append_child( Button.new(text: "click #{i}"))
#   right.append_child(row)
# }

# screen.set_timeout(1, proc {
#   left.text = 'hello'
#   screen.render
# })
# e.padding = Offset.new(top: 0.5, left: 0.4)
# e.style = { bg: 'blue', fg: 'yellow', wrap: true, border: Border.new(style: :double), padding: Offset.new(top: 0.5, left: 0.4)}
# e.style.wrap = true
# e.style, padding: Offset.new(top: 1, left: 2)
# e.style.border = Border.new(style: :double)

# screen.add_listener('destroy', proc { screen.clear; p 'bye' })
# e = Element.new x: 3, y: 2, width: 10, height: 5, ch: 'y'
# e.style = { fg: 'blue', bg: 'white' }
# f = Element.new x: 13, y: 12, width: 10, height: 5, ch: 'K'
# f.style = { fg: 'black', bg: 'red' }
# screen.render e
# screen.render f
