require_relative '../../src/widget/modal'
require_relative '../../src/termgui'
require_relative '../../src/util/unicode-categories'
require_relative 'app_handlers'

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
  attr_accessor :files, :glob, :current, :images, :render_cache, :chs
  def initialize(glob, files)
    @files = files
    @glob = glob
    @current = 0
    @render_cache = true
    @chs = :Cuneiform
  end

  def current_file
    files[current]
  end
end

class App
  include AppHandlers
  attr_accessor :screen, :state, :image_container, :image_widgets
  def initialize(screen, glob)
    @screen = screen
    build_initial_state(glob)
    build_elements
    install_keyboard_shortcuts
  end

  def install_keyboard_shortcuts
    screen.event.add_any_key_listener { |e| handle_key e }
  end

  def handle_key(e)
    return if screen.query_one_by_attribute('entered', true)
    clode_modal(screen)
    if e.key == '+'
      handle_zoom_in
    elsif e.key == '-'
      handle_zoom_out
    elsif e.key == 'left'
      handle_prev
    elsif e.key == 'right'
      handle_next
    elsif e.key == 'w'
      handle_pan_up
    elsif e.key == 's'
      handle_pan_down
    elsif e.key == 'd'
      handle_pan_right
    elsif e.key == 'a'
      handle_pan_left
    elsif e.key == 'b'
      handle_brush_selection
    end
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
          Button.new(text: 'Open', action: proc { `open "#{state.current_file}"` }),
          Button.new(text: 'in', action: proc { handle_zoom_in }),
          Button.new(text: 'out', action: proc { handle_zoom_out }),
          Button.new(text: 'right', action: proc { handle_pan_right }),
          Button.new(text: 'left', action: proc { handle_pan_left }),
          Button.new(text: 'up', action: proc { handle_pan_up }),
          Button.new(text: 'down', action: proc { handle_pan_down }),
          Button.new(text: 'brush', action: proc { handle_brush }),
          Button.new(text: 'state', action: proc { handle_state }),
          Button.new(text: 'help', action: proc { handle_help })
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
    log "Loading '#{File.basename(state.current_file)}'"
    image_container.empty
    if image_widgets[state.current]
      image_container.append_child image_widgets[state.current]
    else
      image_widgets[state.current] = TermGui::Widget::Image.new(
        render_cache: state.render_cache,
        parent:   image_container,
        width: MAX,
        height: MAX,
        src: state.current_file,
        style: Style.new(bg: '#000000'),
        use_bg: false,
        use_fg: true,
        chs: UNICODE_CATEGORIES[state.chs]
      )
    end
    image_widgets[state.current].chs = UNICODE_CATEGORIES[state.chs]
    image_widgets[state.current].refresh(state.render_cache)
    log "'#{File.basename(state.current_file)}' rendered in #{print_ms(t0)}."
  end

  def log(msg)
    @log.clear
    @log.text = msg + ".Unicode Category: '#{state.chs.to_s}'"
    @log.render
  end

end
