require_relative 'util'

# Adds support for Element's x, y, abs_x, abs_y, width, height, abs_width, abs_height
module ElementBounds
  def x=(x)
    set_attribute('x', x)
  end

  def x
    get_attribute('x') || 0
  end

  def abs_x
    if is_percent x
      ((@parent ? @parent.abs_x : 0) + x * (@parent ? @parent.abs_width : @abs_width)).truncate
    else
      ((@parent ? @parent.abs_x : 0) + x).truncate
    end
  end

  def abs_x=(value)
    self.x = value - (@parent ? @parent.abs_x : 0).truncate
  end

  def y=(y)
    set_attribute('y', y)
  end

  def y
    get_attribute('y') || 0
  end

  def abs_y
    if is_percent y
      ((@parent ? @parent.abs_y : 0) + y * (@parent ? @parent.abs_height : @abs_height)).truncate
    else
      ((@parent ? @parent.abs_y : 0) + y).truncate
    end
  end

  def abs_y=(value)
    self.y = value - (@parent ? @parent.abs_y : 0).truncate
  end

  def width=(width)
    set_attribute('width', width)
  end

  def width
    get_attribute('width') || 0
  end

  def abs_width
    # width = get_attribute 'width' || 0

    if (is_percent width) && @parent
      (@parent.abs_width * width).truncate
    else
      width.truncate
    end

    # if (is_percent width) && @parent
    #   width = @parent.abs_width * width
    # end
    # # if (is_percent width) && @parent
    # #   width = @parent.abs_width * width
    # # end
    # width = width.truncate
    # width = width + border_x_size
    # # if style.border
    # #   width = width + 2
    # # end
    # width
  end

  def height=(height)
    set_attribute('height', height)
  end

  def height
    get_attribute('height') || 0
  end

  def abs_height
    # height = get_attribute( 'height') || 0

    if is_percent height
      (@parent ? @parent.abs_height * height : 0).truncate
    else
      height.truncate
    end

    # if (is_percent height) && @parent
    #   height = @parent.abs_height * height
    # end
    # # if (is_percent height) && @parent
    # #   height = @parent.abs_height * height
    # # end
    # height = height.truncate
    # height = height + border_y_size
    # # if style.border
    # #   height = height + 2
    # # end
    # height
  end
end
