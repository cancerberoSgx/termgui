require_relative 'element_bounds'
require_relative 'util'

# adds utilities around style
module ElementStyle
  def style
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

  # def style_focus
    # style.focus ? 
  # end
end