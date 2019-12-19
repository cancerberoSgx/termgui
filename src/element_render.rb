require_relative 'element_box'
require_relative 'util'
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
    # end
  end

  # IMPORTANT: border is rendered in a +2 bigger rectangle that sourounds actual element bounds (abs_* methods)
  def render_border(screen)
    # p 'seba', border
    if border
      # screen.style = border_style
      # box = draw_box(width: abs_width + 2, height: abs_height + 2)
      # box.each do |line|
      #   screen.text abs_x - 1, abs_y - 1, line
      # end
      screen.box abs_x - 1, abs_y - 1, abs_width + 2, abs_height + 2, border.style, style
    end
  end

  def render_text(screen)
    @text.split('\n').each_with_index{|line, i|
    screen.text(abs_content_x, abs_content_y + i, line) if @text
  }
  end

end
