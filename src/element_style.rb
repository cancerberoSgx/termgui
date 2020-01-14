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
    get_attribute('style').assign(style)
  end

  def set_style(name, value)
    o = {}
    o[name] = value
    get_attribute('style').assign(o)
  end

  def get_style(name)
    s = get_attribute('style')
    s.get(name)
  end

  def default_style
    Style.new
  end

  # while "normal" style is defined in @style, focused extra style is defined in @style.focus,
  # so dependently on attributes like `focused` this method performs computation of the "final" style
  def final_style
    result = style.clone
    # if get_attribute('focused')
    #   result.merge
    # end
    result
  end
  # def style_focus
  # style.focus ?
  # end
end
