require_relative '../element'
module TermGui
  module Widget
    # Row container. A row child is rendered at the right of the previous child - all of them in one row.
    # By default it will have width==0.999
    class Row < Element
      attr_accessor :gap
      def initialize(**args)
        super({ width: 0.9999999 }.merge(args))
        @name = 'row'
        @gap = args[:gap]||0
      end

      def layout
        # init_x = abs_content_x
        last_x = abs_content_x
        @children.each do |c|
          c.abs_x = last_x
          last_x += c.abs_width + @gap
        end
      end
    end
  end
end

Row = TermGui::Widget::Row
