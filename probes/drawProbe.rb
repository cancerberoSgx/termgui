# start =
require_relative '../src/screen'
require_relative '../src/style'
require_relative '../src/widget/col'
require_relative '../src/widget/row'
require_relative '../src/widget/modal'
require_relative '../src/widget/button'
require_relative '../src/widget/label'

def test3
  screen = Screen.new
  screen.event.add_key_listener('q') { screen.destroy }
  screen.set_timeout(0.1) do
    screen.text(x: 2, y: 0, text: 'Use UP and DOWN for frequency ENTER ot start...', style: Style.new(fg: 'white'))
    screen.text(x: 2, y: 1, text: 'LEFT and RIGHT for interval', style: Style.new(fg: 'white'))
    screen.text(x: 2, y: 2, text: 'ENTER ot start and q to exit', style: Style.new(fg: 'white'))
    screen.render
  end
  time = 0
  frequency = 0.02
  interval = 0.09
  screen.event.add_key_listener('enter')  do
    screen.event.add_key_listener('up') { frequency += 0.01 }
    screen.event.add_key_listener('down') { frequency -= 0.01 }
    screen.event.add_key_listener('right') { interval = (interval - 0.01) >= 0 ? (interval - 0.01) : 0.01 }
    screen.event.add_key_listener('left') { interval += 0.01 }
    screen.set_interval do
      time += 1
      values = screen.width.times.map do |i|
        (Math.sin(time + i * frequency) * (screen.height / 2) + (screen.height / 2)).round
      end
      screen.clear
      values.each_with_index do |value, index|
        screen.text(x: index, y: value, text: 'x', style: Style.new(fg: [(value * 255 / screen.height), 255 - (value * 255 / screen.height), 133]))
      end
      screen.text(x: 0, y: 0, text: { frequency: frequency, interval: interval }.to_s)
      sleep interval
    end
  end
  # screen.on('destroy'){
  #   # log 'sebs'
  #   # p ({frequency: frequency, interval: interval})
  #   sleep 1
  #   p 'hsdhdhdhd'
  # }
  screen.start
end
test3

def test2
  screen = Screen.new
  screen.install_exit_keys
  time = 0
  interval = 0.08
  frequency = 0.1
  loop do
    time += 1
    values = [] # function values for each screen.width pixel
    screen.width.times.map do |i|
      value = (Math.sin(time + i * frequency) * (screen.height / 2) + (screen.height / 2)).round
      values.push value
    end

    # paint
    screen.clear
    values.each_with_index do |value, index|
      # p index, value
      screen.text(x: index, y: value, text: 'x')
    end
    sleep interval
  end
end
# test2

def test1
  i = 0
  width = 130
  height = 50
  interval = 0.01
  frequency = 1.7
  loop do
    i += interval
    p (Math.sin(i * frequency) * height + height).round
    sleep interval
  end
end
# test1
