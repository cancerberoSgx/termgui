require_relative '../../src/termgui'

def main
  file_name_string = 'probes/assets/apples.png'
  screen = TermGui::Screen.new
gap = 0.02
  left = Element.new(style: {border: Border.new, bg: '#000000'}, width: 0.7-gap, y: 2, x: gap, height: 0.99, parent: screen)
  img = Image.new(
    x: 1,
    y: 1,
    src: file_name_string,
    width: 0.99,
    height: 0.99,
    parent: left,
    style: Style.new(
      bg: '#000000'
    )
  )
  right = Element.new(style: {border: Border.new(style: 'double'), bg: '#203321'}, width: 1-0.7-gap, x: 0.7+gap, y: 1, height: 0.99, parent: screen)
  file_name = right.append_child InputBox.new(value: file_name_string, x: 2, y: 2)
  right.append_child Button.new(text: 'Load', x: 2, y: 5, action: proc { |e|
    if !File.exist?( file_name.value)
      open_modal(screen: screen, content: 'The File does not exists', title: 'Error')
    else
      e.target.text ='Loading...'
      e.target.render
      img.src = file_name.value
      img.render
      e.target.clear
      e.target.text ='Load'
      e.target.render
    end
  })
  screen.start
end
main
