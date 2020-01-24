# warning: execute this in a real terminal (not in vscode's) because of performance

require_relative '../../src/widget/button'
require_relative '../../src/screen'
require_relative '../../src/util'

def test(timeout: 3, box_count: 80, interval: 0.01, render_count: 1, screen_width: 120, screen_height: 32, text_length: 5, no_buffer: false)
  t0 = Time.now
  i = 0
  s = Screen.new_for_testing(width: screen_width, height: screen_height)
  s.renderer.no_buffer = no_buffer
  s.set_timeout(timeout) do
    config = {
      timeout: timeout, box_count: box_count, interval: interval, render_count: render_count, screen_width:
      screen_width, screen_height: screen_height, text_length: text_length, no_buffer: no_buffer
    }
    s.clear
    s.destroy
    print_string "\r
Iteration ##{i} \r
Time: #{Time.now - t0} \r
Config: #{config} \r"
  end

  draw = proc {
    box_count.times do |j|
      s.append_child Button.new(x: random_int(2, s.width - 20), y: random_int(1, s.height - 4), text: "button#{j}")
    end
  }
  step = proc {
    i += 1
    s.empty
    s.clear
    draw.call
    l = s.append_child Label.new(text: "iteration ##{i} **")
    render_count.times { s.render }
    s.set_timeout(interval) do
      step.call
    end
  }
  step.call
  s.start
end

test(render_count: 10, no_buffer: true)
# test(screen_width: nil, screen_height: nil)
