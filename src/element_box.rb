require_relative 'geometry'
require_relative 'element_bounds'
require_relative 'util/hash_object'

# Adds html-like box-model support for Element: margin, padding, border
module ElementBox
  include ElementBounds

  def abs_content_x
    abs_x + abs_padding.left
  end

  def abs_content_y
    abs_y + abs_padding.top
  end

  def abs_content_width
    m = abs_padding
    abs_width - m.left - m.right
  end

  def abs_content_height
    m = abs_padding
    abs_height - m.top - m.bottom
  end

  # returns padding as Offset instance
  def padding
    padding = get_style('padding')
    if !padding
      Bounds.new
    elsif padding.instance_of? Hash
      Offset.from_hash(padding)
    else
      padding
    end
  end

  def padding=(padding)
    set_style('padding', padding)
  end

  # computes absolute padding transforming padding percents to absolute pixel amounts.
  def abs_padding
    p = padding
    Bounds.new(
      top: is_percent(p.top) ? (p.top * abs_height).truncate : p.top,
      bottom: is_percent(p.bottom) ? (p.bottom * abs_height).truncate : p.bottom,
      left: is_percent(p.left) ? (p.left * abs_width).truncate : p.left,
      right: is_percent(p.right) ? (p.right * abs_width).truncate : p.right
    )
  end

  protected

  def border_x_size
    style.border ? 2 : 0
  end

  def border_y_size
    style.border ? 2 : 0
  end
end
