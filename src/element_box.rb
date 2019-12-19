require_relative 'element_bounds'
require_relative 'util'

# Adds html-like box-model support for Element: margin, padding, border
module ElementBox
  include ElementBounds

  # def after_initialize
  #   super
  # end

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
    padding = get_attribute('padding')
    if !padding
      Offset.new
    elsif padding.instance_of? Hash
      Offset.from_hash(padding)
    else
      padding
    end
  end


  # computes absolute padding transforming padding percents to absolute pixel amounts.
  def abs_padding
    p = padding
    Offset.new(
      top: is_percent(p.top) ? (p.top * abs_height).truncate : p.top,
      bottom: is_percent(p.bottom) ? (p.bottom * abs_height).truncate : p.bottom,
      left: is_percent(p.left) ? (p.left * abs_width).truncate : p.left,
      right: is_percent(p.right) ? (p.right * abs_width).truncate : p.right
    )
  end

  # # returns margin as Offset instance
  # def margin
  #   margin = get_attribute('margin')
  #   if !margin
  #     Offset.new
  #   elsif margin.instance_of? Hash
  #     Offset.from_hash(margin)
  #   else
  #     margin
  #   end
  # end

  # # computes absolute margin transforming margin percents to absolute pixel amounts.
  # def abs_margin
  #   m = margin
  #   Offset.new(
  #     top: is_percent(m.top) ? (m.top * abs_height).truncate : m.top,
  #     bottom: is_percent(m.bottom) ? (m.bottom * abs_height).truncate : m.bottom,
  #     left: is_percent(m.left) ? (m.left * abs_width).truncate : m.left,
  #     right: is_percent(m.right) ? (m.right * abs_width).truncate : m.right
  #   )
  # end
end

# Represents a rectangle in the form of {top, left, bottom, top}
class Offset
  attr_accessor :left, :right, :top, :bottom

  def initialize(left: 0, right: 0, top: 0, bottom: 0)
    @left = left
    @right = right
    @top = top
    @bottom = bottom
  end

  def self.from_hash(hash)
    Offset.new(
      top: hash[:top] || 0,
      left: hash[:left] || 0,
      right: hash[:right] || 0,
      bottom: hash[:bottom] || 0
    )
  end
end
