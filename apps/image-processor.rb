require_relative '../src/termgui'

def main
  file_name_string = 'probes/assets/whale.png'
  screen = TermGui::Screen.new
  left = Element.new(style: { border: Border.new, bg: '#000000' }, width: 0.69,height: 0.99,parent: screen)
  img = Image.new(
    src: file_name_string,
    width: 0.99,
    height: 0.99,
    parent: left,
    style: Style.new(
      bg: '#000000'
    )
  )
  right = Element.new(style: { border: Border.new(style: 'double'), bg: '#203321' }, width: 0.3, x: 0.7  , height: 0.99, parent: screen)
  file_name = right.append_child InputBox.new(value: file_name_string, x: 1, y: 1)
  right.append_child Button.new(text: 'Load', y: 4, x:1, action: proc { |e|
    if !File.exist?(file_name.value)
      open_modal(screen: screen, content: 'The File does not exists', title: 'Error')
    else
      e.target.text = 'Loading...'
      e.target.render
      img.src = file_name.value
      img.render
      e.target.clear
      e.target.text = 'Load'
      e.target.render
    end
  })
  screen.event.add_key_listener('w'){
    img.zoom = [img.zoom - 0.1, 0.0].max
    img.refresh(true)
  }  
  screen.event.add_key_listener('s'){
    img.zoom = [img.zoom + 0.1, 10.0].min
    img.refresh(true)
  }
  screen.event.add_key_listener('right'){
    img.pan_x = [img.pan_x + 0.1, 1.0].min
    img.refresh(true)
  }
  screen.event.add_key_listener('left'){
    img.pan_x =[img.pan_x - 0.1, 0.0].max
    img.refresh(true)
  }
  screen.event.add_key_listener('up'){
    img.pan_y = [img.pan_y - 0.1, 0.0].max
    img.refresh(true)
  }
  screen.event.add_key_listener('down'){
    img.pan_y = [img.pan_y + 0.1, 1.0].min
    img.refresh(true)
  }
  screen.start
end
main
