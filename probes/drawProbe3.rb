require_relative '../src/termgui'

def int(min = 0, max = 10)
  (min..max).to_a.sample
end

def test1
  s = Screen.new
  s.install_exit_keys
  s.set_timeout(0.1) do
    s.text(x: 0, y: 0, text: 'ENTER to generate, q to exit')
  end
  s.event.add_key_listener('enter') do
    s.height.times  do |y|
      s.width.times do |x|
        s.text(x: x, y: y, text: ' ', style: Style.new(bg: [int(0, 255), int(0, 255), int(0, 255)]))
      end
    end
  end
  s.start
end
test1
