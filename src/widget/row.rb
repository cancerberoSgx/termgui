require_relative '../element'

# Row container. A row child is rendered at the right of the previous child - all of them in one row.
# A row often need to know its height and by default it will have width==0.999
class Row < Element
  def initialize(*args)
    super *args
    @name = 'row'
  end

  def layout
    init_x = abs_content_x
    last_x = init_x
    @children.each do |c|
      c.x = last_x - init_x
      last_x += c.abs_width
    end
  end
end
