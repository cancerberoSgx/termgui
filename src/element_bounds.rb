# frozen_string_literal: true

module ElementBounds
  def x=(x)
    set_attribute('x', x)
  end

  def x
    get_attribute('x')
  end

  def abs_x
    if is_precent x
      ((@parent ? @parent.abs_x : 0) + x * (@parent ? @parent.abs_width : @abs_width)).truncate
    else
      ((@parent ? @parent.abs_x : 0) + x).truncate
    end
  end

  def y=(y)
    set_attribute('y', y)
  end

  def y
    get_attribute 'y'
  end

  def abs_y
    if is_precent y
      ((@parent ? @parent.abs_y : 0) + y * (@parent ? @parent.abs_height : @abs_height)).truncate
    else
      ((@parent ? @parent.abs_y : 0) + y).truncate
    end
  end

  def width=(width)
    set_attribute('width', width)
  end

  def width
    get_attribute 'width'
  end

  def abs_width
    width = get_attribute 'width'
    width ||= 0
    if (is_precent width) && @parent
      (@parent.abs_width * width).truncate
    else
      width.truncate
    end
  end

  def height=(height)
    set_attribute('height', height)
  end

  def height
    get_attribute 'height'
  end

  def abs_height
    height = get_attribute 'height'
    height ||= 0
    if is_precent height
      (@parent ? @parent.abs_height * height : 0).truncate
    else
      height.truncate
    end
  end

  protected

  def is_precent(val)
    val > 0 && val < 1
  end
end
