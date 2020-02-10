require_relative 'element_box'
require_relative 'element_style'
require_relative 'util'
require_relative 'util/wrap'
require_relative 'log'
require_relative 'box'

# implements element rendering (self, border, child, text) for which it depends on ElementBox
module ElementRender
  include ElementBox
  include ElementStyle

  attr_accessor :dirty

  def initialize(**args)
    super
    @render_cache = args[:render_cache] || false
    @dirty = true
    @render_cache_data = nil
    on(:bounds_change) do
      @dirty = true
    end
  end

  def border
    style&.border
  end

  def render(screen = root_screen, force = false)
    self.dirty = true if force
    return '' unless screen

    trigger(:before_render)

    layout
    if @render_cache && !dirty && @render_cache_data
      screen.write @render_cache_data
    else
      @render_cache_data = [
        render_border(screen),
        render_self(screen),
        render_text(screen)
      ].join('')
    end
    trigger(:after_render)
    self.dirty = false if @render_cache
    [@render_cache_data, render_children(screen)].join('')
  end

  def root_screen
    @parent&.root_screen
  end

  def clear
    root_screen.rect(x: abs_x, y: abs_y, width: abs_width, height: abs_height, style: parent.final_style) if parent && root_screen
  end

  protected

  def render_self(screen)
    screen.rect(
      x: abs_x + (border ? 1 : 0),
      y: abs_y + (border ? 1 : 0),
      width: abs_width - (border ? 2 : 0),
      height: abs_height - (border ? 2 : 0),
      ch: get_attribute('ch'),
      style: final_style
    )
  end

  # IMPORTANT: border is rendered in a +2 bigger rectangle that sourounds actual element bounds (abs_* methods)
  def render_border(screen)
    border ? screen.box(abs_x, abs_y, abs_width, abs_height, border.style, border_style) : ''
  end

  def render_text(screen)
    (render_text_lines.map.with_index do |line, i|
      screen.text(x: abs_content_x, y: abs_content_y + i, text: line, style: final_style)
    end).join('')
  end

  def render_children(screen)
    (@children.map do |c|
      c.render(screen)
    end).join('')
  end

  def render_text_lines(text = @text || '')
    text&.length ? (style.wrap ? wrap_text(text, abs_content_width) : text.split('\n')) : []
  end

  # can be used by text widgets like labels or buttons to automatically set preffered size according to its text
  def render_text_size(text = @text)
    lines = render_text_lines(text)
    width = lines.map(&:length).max
    height = lines.length
    { width: width, height: height }
  end

  def layout
  end
end
