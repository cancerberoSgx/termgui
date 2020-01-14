require_relative '../element'

# Column container. A column child is rendered at the bottom of the previous child - all of them in one column.
# By default it will have height==0.999
class Col < Element
  def initialize(*args)
    # @height = args[:height] || 0.99
    super
    @name = 'col'
    # @height = @height || 0.999
    # @height = 0.99
  end

  def layout
    init_y = abs_content_y
    last_y = init_y
    @children.each do |c|
      last_y += 1 if c.style.border
      c.abs_y = last_y - init_y
      last_y += c.abs_height
      last_y += 1 if c.style.border
    end
  end
end
