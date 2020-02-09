require_relative '../src/termgui'

def test3
  screen = Screen.new(
    children: [
      Element.new(
        x: 0.2,
        y: 0.2,
        width: 0.8,
        height: 0.8,
        style: { bg: '#44ee66', border: { style: 'double' } },
        text: 'lkaj sdlkajs ldkjalskjdlaksjd lkajsldkjalsk djlakjs ldkjalskdj laksd'
      )
    ]
  )
  screen.event.add_key_listener('h') do
    TermGui::Widget::Modal.open(
      screen: screen,
      title: 'Title 123',
      content:  ' kasdhfajksdlhf alksjd fhlkaj shdlfkj ahsd716827 3817 26387162873 61872 638172 63871 6238716 2837 61823 '
      )
  end
  screen.start
end
test3
