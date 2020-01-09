require_relative '../element'

# Row container. A row child is rendered at the right of the previous child - all of them in one row.
# By default it will have width==0.999
class Row < Element
  def initialize(*args)
    super
    @name = 'row'
    # # @width = @width || 0.999
    # @width = 0.99
  end

  def layout
    init_x = abs_content_x
    last_x = init_x
    @children.each do |c|
      if c.style.border
        last_x += 1
      end
      c.abs_x = last_x - init_x
      last_x += c.abs_width
      if c.style.border
        last_x += 1
      end
    end
  end
end
