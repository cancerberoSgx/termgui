require_relative '../src/widget/inputbox'
require_relative '../src/widget/button'
require_relative '../src/screen'
require_relative '../src/log'

def test1
  s = Screen.new
  
  s.append_child Button.new(x: 2, y: 2, text: 'button')
  input = s.append_child Label.new(x: 12, y: 8, text: 'input: ')
  s.append_child InputBox.new(
    x: 12, y: 2, text: 'text', dynamic_width: true,
    input: proc { |e|
             input.text = 'input: ' + e.value
             input.root_screen.clear
             input.root_screen.render
           },
    escape: proc {
      input.text = 'escape'
      input.root_screen.clear
      input.root_screen.render
    }
  )
  s.start
end
test1
