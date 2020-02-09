require_relative 'geometry'
require_relative 'element_bounds'
require_relative 'util/hash_object'

# Adds html-like box-model support for Element: margin, padding, border
module ElementBox
  include ElementBounds

  def abs_content_x
    abs_x + abs_padding.left + ( border ? 1 : 0)
  end

  def abs_content_y
    abs_y + abs_padding.top+ ( border ? 1 : 0)
  end

  def abs_content_width
    m = abs_padding
    abs_width - m.left - m.right - ( border ? 2 : 0)
  end

  def abs_content_height
    m = abs_padding
    abs_height - m.top - m.bottom - ( border ? 2 : 0)
  end

  def abs_content_bounds
    y = abs_content_y
    x = abs_content_x
    Bounds.new(left: x, right: x + abs_content_width, top: y, bottom: y + abs_content_height)
  end

  def abs_content_box
    Rectangle.new(x: abs_content_x, y: abs_content_y, width: abs_content_width, height: abs_content - abs_content_height)
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
    trigger :bounds_change
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
end
