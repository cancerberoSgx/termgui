require_relative 'element_bounds'
require_relative 'util'

# adds utilities around style
module ElementStyle
  def style
    set_attribute('style', ElementStyle.default_style) if get_attribute('style') == nil
    get_attribute('style')
  end

  def style=(style)
    s = style.instance_of?(Hash) ? Style.from_hash(style) : style
    set_attribute('style', s)
  end

  def style_assign(style)
    self.style = self.style.assign(style)
  end

  def get_style(name)
    s = get_attribute('style')
    s.get(name)
  end

  def default_style
    # s = get_attribute('default_style')
    # if s
    #   Style.from_hash(s).clone
    # else
    #   Style.new
    # end
 Style.new
  end

  # while "normal" style is defined in @style, focused extra style is defined in @style.focus,
  # so dependently on attributes like `focused` this method performs computation of the "final" style
  def final_style
    result = parent && get_attribute('style-cascade') != 'prevent' ? parent.final_style.clone .assign(style) : style.clone
    result.assign(style.focus) if get_attribute('focused')
    result.assign(style.enter) if get_attribute('entered')
    result.assign(style.action) if get_attribute('actioned')
    result
  end

  # computes current border style according to style, style.border, style.focus.border, etc in the right order
  def border_style
    s = final_style
    if border
      s = s.assign(border)
      s.assign(style.focus&.border) if get_attribute('focused')
      s.assign(style.enter&.border) if get_attribute('entered')
      s.assign(style.action&.border) if get_attribute('actioned')
    end
    s
  end
end
