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
        # w = w + 2 if w != nil && style.border
        update_width if !w || w.zero?
        h = args[:height] || 0
        # h = h + 2 if h != nil && style.border
        update_height if !h || h.zero?
      end

      def update_width
        self.width = render_text_size[:width]
      end

      def update_height
        self.height = render_text_size[:height]
      end
    end
  end
end

Label = TermGui::Widget::Label
