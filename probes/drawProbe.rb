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
  screen.install_exit_keys
  time = 0
  frequency = 0.1
  i = 0
  screen.set_interval do
    time += 1
    values = screen.width.times.map { |i| (Math.sin(time + i * frequency) * screen.height + screen.height).round }
    screen.clear
    values.each_with_index do |value, index|
      screen.text(index, value, 'x')
    end
  end
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
      value = (Math.sin(time + i * frequency) * screen.height + screen.height).round
      values.push value
    end

    # paint
    screen.clear
    values.each_with_index do |value, index|
      # p index, value
      screen.text(index, value, 'x')
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
