require_relative '../element'
module TermGui
  module Widget
    # Row container. A row child is rendered at the right of the previous child - all of them in one row.
    # By default it will have width==0.999
    class Row < Element
      def initialize(*args)
        super
        @name = 'row'
      end

      def layout
        init_x = abs_content_x
        last_x = init_x
        @children.each do |c|
          last_x += 1 if c.style.border
          c.abs_x = last_x - init_x
          last_x += c.abs_width
          last_x += 1 if c.style.border
        end
      end
    end
  end
end

Row = TermGui::Widget::Row
