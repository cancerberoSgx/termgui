require_relative 'util'
require_relative 'geometry'

# Adds support for Element's x, y, abs_x, abs_y, width, height, abs_width, abs_height, offset (scroll viewport)
module ElementBounds
  def initialize(**args)
    super
    install(:bounds_change)
  end

  def x=(x)
    set_attribute('x', x)
    trigger :bounds_change
  end

  def x
    get_attribute('x') || 0
  end

  def abs_x
    val = if is_percent x
            ((@parent ? @parent.abs_x : 0) + x * (@parent ? @parent.abs_width : abs_width)).truncate
          else
            ((@parent ? @parent.abs_x : 0) + x).truncate
          end
    o = @parent && parent.offset
    val -= o.left if o
    # val -= 1 if border
    val
  end

  def offset
    v = get_attribute('offset')
    set_attribute('offset', v = Offset.new) unless v
    v
  end

  def offset=(value)
    set_attribute('offset', value)
    trigger :bounds_change
  end

  def abs_x=(value)
    # TODO: parent offset
    self.x = value - (@parent ? @parent.abs_x : 0).truncate
  end

  def y=(y)
    set_attribute('y', y)
    trigger :bounds_change
  end

  def y
    get_attribute('y') || 0
  end

  def abs_y
    val = if is_percent y
            ((@parent ? @parent.abs_y : 0) + y * (@parent ? @parent.abs_height : abs_height)).truncate
          else
            ((@parent ? @parent.abs_y : 0) + y).truncate
          end
    o = @parent && parent.offset
    val -= o.top if o
    # val += 1 if border
    val
  end

  def abs_y=(value)
    # TODO: parent offset
    self.y = value - (@parent ? @parent.abs_y : 0).truncate
  end

  def width=(width)
    set_attribute('width', width)
    trigger :bounds_change
  end

  def width
    get_attribute('width') || 0
  end

  def abs_width
    val = if (is_percent width) && @parent
            (@parent.abs_width * width).truncate
          else
            width.truncate
    end
    val += 2 if border
    val
  end

  def height=(height)
    set_attribute('height', height)
    trigger :bounds_change
  end

  def height
    get_attribute('height') || 0
  end

  def abs_height
    val = if is_percent height
            (@parent ? @parent.abs_height * height : 0).truncate
          else
            height.truncate
    end
    val += 2 if border&.style
    val
  end
end
