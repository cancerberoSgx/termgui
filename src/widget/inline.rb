require_relative '../element'
module TermGui
  module Widget
    # an inline layout - similar to HTML display: inline - so I can add arbitrary elements. 
    # it will break when there is no more space and resize itself.
    # TODO: almost there...
    class Inline < Element
      attr_accessor :horizontal_gap, :vertical_gap
      def initialize(**args)
        super({ width: 0.9999999 }.merge(args))
        @name = 'inline'
        @horizontal_gap = args[:horizontal_gap]||0
        @vertical_gap = args[:vertical_gap]||0
      end

      def layout
        last_y = abs_content_y
        row_max_height = 1+ @vertical_gap
        last_x = abs_content_x
        total_height=0
        @children.each do |c|
          c.abs_x = last_x
          c.abs_y = last_y
          row_max_height = [row_max_height, c.abs_height].max
          last_x += c.abs_width + @horizontal_gap
          if last_x + @horizontal_gap+c.abs_width > abs_content_y + abs_content_width
            last_x = abs_content_x
            last_y += row_max_height + @vertical_gap
            total_height+=row_max_height+@vertical_gap
            row_max_height = 1+ @vertical_gap
          end
        end
        self.height = [total_height + abs_padding.top + abs_padding.bottom + row_max_height, self.abs_height].max ##TODO borders
      end
    end
  end
end

Inline = TermGui::Widget::Inline

