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

def open_modal(
  screen: nil,
  title: 'Modal',
  content: Label.new(text: 'Content'),
  buttons: [
    Button.new(text: 'OK', action: proc { close_modal screen })
  ]
)
  screen.rect(x: 2, y: 2, width: [content.width, '(press ESC to close)'.length].max + 3, height: 7 + content.height, ch: ' ')
  screen.text 3, 3, title
  screen.text 3, 4, '(press ESC to close)'
  content.x = 3
  content.y = 5
  content.render screen
  buttons.each do |b|
    b.y = content.height + 6
    b.x = 3
    b.render screen
  end
end

def close_modal(screen)
  screen.render
end

screen = Screen.new
screen.input.install_exit_keys

# screen.set_timeout(0.5){
#   screen.rect(x: 2, y: 2, width: 12, height: 3, ch: 'x')
#   }

left = Col.new(width: 0.4, height: 0.99, style: { bg: 'red' })
left_labels = (0..8).map { |i| left.append_child Label.new(text: "Label_#{i}") }
right = Col.new(width: 0.6, height: 0.99, x: 0.4, style: Style.new(bg: 'blue'))
right_buttons = (0..4).map { |i| right.append_child Button.new(text: "Button_#{i}", x: 0.5) }
[left, right].each { |widget| screen.append_child widget }

b1 = screen.append_child Button.new(text: 'hello', y: 0.6, x: 0.4, action: proc {
  open_modal(screen: screen)
})

b2 = screen.append_child Button.new(text: 'world' + screen.query_by_attribute('focusable', true).length.to_s, y: 0.8, x: 0.2)
b2.set_attribute('action', proc {
  open_modal(screen: screen)
})
# b2.style.focus = Style.new(bold: true, bg: 'white')

b1.on(:action) { log 'action' }
b1.on('action') { log 'action' }

# p right_buttons[0].style
screen.focus.subscribe(:focus) do |e|
  e[:focused]&.style&.bg= 'white'
  e[:focused]&.style&.fg= 'blue'
  e[:previous]&.style&.bg= 'black'
  e[:previous]&.style&.fg= 'magenta'
  screen.render e[:focused]
  screen.render e[:previous]
  # log 'focused'
end
# screen.query_by_attribute('focusable', true).length.times {screen.focus.focus_next}

screen.start
