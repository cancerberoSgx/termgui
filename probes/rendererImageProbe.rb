require_relative '../src/termgui'

def test1
  screen = Screen.new
  screen.set_timeout do
    screen.clear
    t0 = Time.now
    screen.renderer.fast_colouring = true
    screen.image(x: 10, y: 5, image: 'probes/assets/apples.png')
    screen.text(text: Time.now - t0); t0 = Time.now
    screen.image(x: 40, y: 33, image: 'probes/assets/brazil.png')
    screen.text(text: Time.now - t0, y: 1); t0 = Time.now
    screen.image(x: 100, y: 55, image: 'probes/assets/sample.png', double_cols: true)
    screen.text(text: Time.now - t0, y: 2); t0 = Time.now
  end
  screen.start
end

def test2
  screen = Screen.new
  screen.set_timeout do
    padding_x = 10
    padding_y = 2
    screen.text(text: 'Loading...')
    images = (ARGV.length>0 ? ARGV  : `ls /Users/wyeworks/Documents/assets/*`.split("\n")).map do |f|
      img = TermGui::Image.new(f)
      img.scale(
        width: [screen.width - padding_x * 2, img.width].min,
        height: [screen.height - padding_y * 2, img.height].min
      )
    end
    current = 0
    render_current = proc {
      screen.clear
      t0 = Time.now
      screen.text(text: 'Loading...')
      screen.image(x: padding_x, y: padding_y, image: images[current], ch: CUNEIFORM, bg: false, fg: true, style: Style.new(bg: '#000000'))
      # screen.image(x: padding_x, y: padding_y, image: images[current], ch: BRAILE_FILLED, bg: true, fg: false, style: Style.new(fg: '#aaaaaa'))
      screen.text(text: "'#{images[current].path}' rendered in #{Time.now - t0} seconds.")
    }
    screen.event.add_key_listener('left') do
      if current > 0
        current -= 1
        render_current.call
      else
        screen.alert
      end
    end
    screen.event.add_key_listener('right') do
      if current < images.length - 1
        current += 1
        render_current.call
      else
        screen.alert
      end
    end
    screen.event.add_key_listener('up') do
      screen.renderer.fast_colouring = true
      render_current.call
    end
    screen.event.add_key_listener('down') do
      screen.renderer.fast_colouring = false
      render_current.call
    end
   
    render_current.call
  end
  screen.start
end

test2



