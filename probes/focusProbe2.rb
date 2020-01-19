require_relative '../src/termgui'

def int(min = 0, max = 10)
  (min..max).to_a.sample
end

def color
  [int(0, 255), int(0, 255), int(0, 255)]
end

def test1
  s = Screen.new
  s.install_exit_keys
  s.set_timeout(0.1) do
    s.text(x: 0, y: 0, text: 'TAb to focus, UP to change, ENTER to start')
  end
  s.event.add_key_listener('enter') do
    10.times do |i|
      b = s.append_child TermGui::Widget::Button.new(text: "Button #{i}", x: int(0, s.width - 20), y: int(1, s.height))
      b.root_screen.event.add_key_listener('up') do |_event|
        if b.get_attribute('focused')
          b.style.fg = color
          b.style.bg = color
          b.style.focus.fg = color
          b.style.focus.bg = color
          b.render
        end
      end
    end
    s.render
  end
  s.start
end
test1
