require_relative '../src/termgui'

def test1
  s = Screen.new

  10.times.map do |i|
    timeout = [0.2, 0.5, 0.8, 1.1, 1.5, 2, 2.5].sample
    b = s.append_child Button.new(x: int(0, s.width - 10), y: int(1, s.height - 4), text: "Button #{i}")
    s.set_interval(timeout) do
      b.style = Style.new(bg: [int(0, 255), int(0, 255), int(0, 255)])
      b.render
    end
  end
  s.start
end
test1

# def int(min = 0, max = 10)
#   (min..max).to_a.sample
# end

# s = Screen.new
#
# s.set_timeout(0.1) do
#   # s.set_interval(1){s.text(x:0,y:0,text:'1_'+Time.now.to_s)}
#   s.set_interval(1) do
#     log 'call'
#     s.text(x: 0, y: 0, text: 'ENTER to generate, q to exit' + int(0, 100).to_s)
#   end
#   s.text(x: 0, y: 0, text: 'ENTER to generate, q to exit')

#   # s.set_interval(2){p '2'}
# end
# s.start
