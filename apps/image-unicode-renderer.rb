require_relative '../src/termgui'
# menu: 
#  * open imagen original
#  * select unicode category
#  * export to svg/html (TODO)
#  * select files (glob)
#  * style options:
#   * bold, blink, inverse, underline, etc...
#   * render in fg ? if not choose fg color
#   * render in bg ? if not choose bg color
#   * chose ch: 
#     * can be an unicode category
#     * can be a single char
#     * can be a custom string.split()
#  * Animations / transformations
#    * woule be awesome to control pixel animations - changing ch, randomly deviating from original color, 
#    * or by pressing enter to see how it changes

MAX = 0.99999999
def test2
  screen = Screen.new(children: [
    Col.new(width: MAX, children: [
      Row.new(height: 0.15, style: {bg: 'blue'}),
      Row.new(height: 0.85, style: {bg: 'red', border: Border.new})
    ])
  ])
  # screen.set_timeout do
  #   padding_x = 10
  #   padding_y = 2
  #   screen.text(text: 'Loading...')
  #   images = (ARGV.length>0 ? ARGV  : `ls /Users/wyeworks/Documents/assets/*`.split("\n")).map do |f|
  #     img = TermGui::Image.new(f)
  #     img.scale(
  #       width: [screen.width - padding_x * 2, img.width].min,
  #       height: [screen.height - padding_y * 2, img.height].min
  #     )
  #   end
  #   current = 0
  #   render_current = proc {
  #     screen.clear
  #     t0 = Time.now
  #     screen.text(text: 'Loading...')
  #     screen.image(x: padding_x, y: padding_y, image: images[current], ch: CUNEIFORM, bg: false, fg: true, style: Style.new(bg: '#000000'))
  #     # screen.image(x: padding_x, y: padding_y, image: images[current], ch: BRAILE_FILLED, bg: true, fg: false, style: Style.new(fg: '#aaaaaa'))
  #     screen.text(text: "'#{images[current].path}' rendered in #{Time.now - t0} seconds.")
  #   }
  #   screen.event.add_key_listener('left') do
  #     if current > 0
  #       current -= 1
  #       render_current.call
  #     else
  #       screen.alert
  #     end
  #   end
  #   screen.event.add_key_listener('right') do
  #     if current < images.length - 1
  #       current += 1
  #       render_current.call
  #     else
  #       screen.alert
  #     end
  #   end
  #   screen.event.add_key_listener('up') do
  #     screen.renderer.fast_colouring = true
  #     render_current.call
  #   end
  #   screen.event.add_key_listener('down') do
  #     screen.renderer.fast_colouring = false
  #     render_current.call
  #   end
   
  #   render_current.call
  # end
  screen.start
end

test2



