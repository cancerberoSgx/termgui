require_relative '../src/termgui'
# menu:
#  * open imagen original
#  * select unicode category
#  * export to svg/html (TODO)
#  * select files (glob)
# transparent_color, ignore alpha
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

class State
  attr_accessor :files, :glob, :current, :images, :render_cache
  def initialize(glob, files)
    @files = files
    @glob = glob
    @current = 0
    @render_cache = true
  end
end

class App
  attr_accessor :screen, :state, :image_container, :image_widgets
  def initialize(screen, glob)
    @screen = screen
    build_initial_state(glob)
    build_elements
  end

  def build_elements
    screen.append_child(
      Col.new(width: MAX, height: MAX, children: [
        (@log = Row.new(height: 2, width: MAX, text: 'hello', style: { fg: '#aaaaaa' })),
        Row.new(height: 4, style: { bg: '#edaa88' }, gap: 1, children: [
          InputBox.new(value: state.glob),
          Button.new(text: 'Load', action: proc { |e| handle_load e }),
          Button.new(text: 'Next', action: proc { handle_next }),
          Button.new(text: 'Prev', action: proc { handle_prev }),
          Button.new(text: 'Open', action: proc { `open "#{state.files[state.current]}"` }),
          Button.new(text: 'in', action: proc { handle_zoom_in }),
          Button.new(text: 'out', action: proc { handle_zoom_out }),
          Button.new(text: 'right', action: proc { handle_pan_right }),
          Button.new(text: 'left', action: proc { handle_pan_left }),
          Button.new(text: 'up', action: proc { handle_pan_up }),
          Button.new(text: 'down', action: proc { handle_pan_down })
        ]),
        (@image_container = Row.new(height: MAX, width: MAX))
    ])
    )
  end

  def build_initial_state(glob)
    files = (!ARGV.empty? ? ARGV : `ls #{glob}`.split("\n"))
    @state = State.new(glob, files)
  end

  def start
    log "Loading #{state.files.length} files..."
    @image_widgets = state.files.map { nil }
    screen.start do
      render_current
    end
  end

  def render_current
    t0 = Time.now
    log 'Loading... ' + state.files[state.current]
    image_container.empty
    if image_widgets[state.current]
      image_container.append_child image_widgets[state.current]
    else
      image_widgets[state.current] = TermGui::Widget::Image.new(
        render_cache: state.render_cache,
        parent:   image_container,
        x: 0,
        y: 0,
        width: MAX,
        height: MAX,
        src: state.files[state.current],
        style: Style.new(bg: '#000000'),
        use_bg: false,
        use_fg: true,
        chs: BRAILE
      )
    end
    image_widgets[state.current].refresh(state.render_cache)
    log "'#{state.files[state.current]}' rendered in #{print_ms(t0)}."
  end

  def log(msg)
    @log.clear
    @log.text = msg
    @log.render
  end

  def handle_next
    if state.current < state.files.length - 1
      state.current += 1
      render_current
    else
      screen.alert
    end
  end

  def handle_prev
    if state.current > 0
      state.current -= 1
      render_current
    else
      screen.alert
    end
  end

  def handle_zoom_in
    image_widgets[state.current].zoom = [image_widgets[state.current].zoom - 0.1, 0.0].max
    image_widgets[state.current].refresh(true)
  end

  def handle_zoom_out
    image_widgets[state.current].zoom = [image_widgets[state.current].zoom + 0.1, 10.0].min
    image_widgets[state.current].refresh(true)
  end

  def handle_pan_right
    image_widgets[state.current].pan_x = [image_widgets[state.current].pan_x + 0.1, 1.0].min
    image_widgets[state.current].refresh(true)
  end

  def handle_pan_left
    image_widgets[state.current].pan_x = [image_widgets[state.current].pan_x - 0.1, 0.0].max
    image_widgets[state.current].refresh(true)
  end

  def handle_pan_up
    image_widgets[state.current].pan_y = [image_widgets[state.current].pan_y - 0.1, 0.0].max
    image_widgets[state.current].refresh(true)
  end

  def handle_pan_down
    image_widgets[state.current].pan_y = [image_widgets[state.current].pan_y + 0.1, 1.0].min
    image_widgets[state.current].refresh(true)
  end

  def handle_load(e)
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
  end
end

app = App.new(Screen.new, '/Users/wyeworks/Documents/assets/*.png')
app.start
