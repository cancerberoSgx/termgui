require_relative '../element'

# Row container. A row child is rendered at the right of the previous child - all of them in one row.
# A row often need to know its height and by default it will have width==0.999
class Row < Element
  def initialize(*args)
    super *args
    @name = 'row'
    width ||= 0.99
  end

  def render_children
    init_x = abs_content_x
  end
end
