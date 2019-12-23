require_relative 'element_box'
require_relative 'util'
require_relative 'util/wrap'
require_relative 'log'
require_relative 'box'

# implements element rendering (self, border, child, text) for which it depends on ElementBox
module ElementRender
  include ElementBox

  def border
    style&.border
  end

  # computes current border style according to style, style.border, style.focus.border, etc in the right order
  def border_style
    s = style.clone
    s = s.assign(border) if border
    s
  end

  protected

  def render_self(screen)
    render_border screen
    screen.style = style if style
    screen.rect(
      x: abs_x,
      y: abs_y,
      width: abs_width,
      height: abs_height,
      ch: ch
    )
    # screen.style = style.clone.assign style.border if style&.border
  end

  # IMPORTANT: border is rendered in a +2 bigger rectangle that sourounds actual element bounds (abs_* methods)
  def render_border(screen)
    screen.style = border_style
    # p border_style
    screen.box abs_x - 1, abs_y - 1, abs_width + 2, abs_height + 2, border.style, style if border
  end

  def render_text(screen)
    if @text
      render_text_lines.each_with_index do |line, i|
        screen.text(abs_content_x, abs_content_y + i, line)
      end
    end
  end

  def render_text_lines
    # p 'style.wrap', style.wrap
    style.wrap ? wrap_text(@text, abs_content_width) : @text.split('\n')
  end

  # can be used by text widgets like labels or buttons to automatically set preffered size according to its text
  def render_text_size
    lines = render_text_lines
    width = lines.map(&:length).max
    height = lines.length
    p lines, width, height, style.wrap
    { width: width, height: height }
  end
end
