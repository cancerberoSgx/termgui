require_relative 'util'
require_relative 'geometry'

# Adds support for Element's x, y, abs_x, abs_y, width, height, abs_width, abs_height, offset (scroll viewport)
module ElementBounds
  def x=(x)
    set_attribute('x', x)
  end

  def x
    get_attribute('x') || 0
  end

  def abs_x
    if is_percent x
      val = ((@parent ? @parent.abs_x : 0) + x * (@parent ? @parent.abs_width : abs_width)).truncate
    else
      val = ((@parent ? @parent.abs_x : 0) + x).truncate
    end
    o = @parent && parent.offset
    val -= o.left if o
    val
  end

  def offset
    v = get_attribute('offset')
    set_attribute('offset', v = Offset.new) unless v
    v
  end

  def offset=(value)
    set_attribute('offset', value)
  end

  def abs_x=(value)
    # //TODO: offset
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
      val = ((@parent ? @parent.abs_y : 0) + y * (@parent ? @parent.abs_height : abs_height)).truncate
    else
      val = ((@parent ? @parent.abs_y : 0) + y).truncate
    end
    o = @parent && parent.offset
    val -= o.top if o
    val
  end

  def abs_y=(value)
    # TODO: parent offset
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

  end

  def height=(height)
    set_attribute('height', height)
  end

  def height
    get_attribute('height') || 0
  end

  def abs_height
    if is_percent height
      (@parent ? @parent.abs_height * height : 0).truncate
    else
      height.truncate
    end

  end
end
