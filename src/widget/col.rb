require_relative '../element'
module TermGui
  module Widget
    # Column container. A column child is rendered at the bottom of the previous child - all of them in one column.
    # By default it will have height==0.999
    class Col < Element
      def initialize(**args)
        # p(({height: 0.99}.merge(args))[:height])
        super({height: 0.999}.merge(args))
        # p height, abs_height
        @name = 'col'
      end

      def layout
        # init_y = abs_content_y
        last_y = abs_content_y
        @children.each do |c|
          # last_y += 1 if c.style.border
          c.abs_y = last_y 
          last_y += c.abs_height
          # last_y += 1 if c.style.border
        end
      end
    end
  end
end

Col = TermGui::Widget::Col
