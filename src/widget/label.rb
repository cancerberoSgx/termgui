require_relative '../element'
module TermGui
  module Widget
    # A label widget. It's size, if not given, will be computed according to its text.
    class Label < Element
      def initialize(**args)
        super
        @name = 'label'
        # sets width and height according to size rendering:
        w = args[:width] || 0
        update_width if !w || w.zero?
        h = args[:height] || 0
        update_height if !h || h.zero?
      end

      def update_width(text=@text)
        self.width = render_text_size(text)[:width]
      end

      def update_height(text=@text)
        self.height = render_text_size(text)[:height]
      end
    end
  end
end

Label = TermGui::Widget::Label
