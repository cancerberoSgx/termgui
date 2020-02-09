require_relative '../src/termgui'

def test3
  screen = Screen.new(children: [
    Element.new(x: 0.2, y: 0.2, width: 0.8, height: 0.8, style: {bg: '#44ee66', border: {style: 'double'}}, text: 'hshshshshs')
  ])
  screen.event.add_key_listener('h') do
    TermGui::Widget::Modal.open(screen: screen)
  end
  screen.start
end
test3
