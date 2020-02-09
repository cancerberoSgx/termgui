require_relative '../termgui'

module TermGui
  module Widget
    # analog to HTMLImageElement. Note that the image will be loaded only on render. Also it will be resized according to abs_content
    # Properties:
    # src: file path or TermGui::Image ot load
    # transparent_color color to blend transparent pixels, by default style.bg
    # ignore_alpha. if true alpha channel is ignored (could be faster)
    # use_bg (true by default) will paint pixels using style.bg
    # use_fg (false by default) will paint using style.fg
    class Image < Element
      def initialize(**args)
        super
        @name = 'image'
        @src = args[:src]
        @use_bg = args[:use_bg] == nil ? true : args[:use_bg]
        @use_fg = args[:use_fg] == nil ? false : args[:use_fg]
        @transparent_color = args[:transparent_color]
        @ignore_alpha = args[:ignore_alpha]
      end

      def image
        if !@image && @src
          @image = @src.is_a?(String) ? TermGui::Image.new(@src) : @src
          @image = @image.scale(
            width: abs_content_width,
            height: abs_content_height
          )
        end
        @image
      end

      def render_self(screen)
        [
          super,
          image ? screen.image(
            x: abs_content_x,
            y: abs_content_y,
            transparent_color: !@ignore_alpha ? TermGui.to_rgb(@transparent_color || final_style.bg || '#000000') : nil,
            image: image,
            bg: @use_bg,
            fg:  @use_fg,
            style: final_style,
            ch: get_attribute('ch')
          ) : ''
        ].join('')
      end

      def src=(v)
        @src = v
        @image = nil
        image
      end
    end
  end
end

Image = TermGui::Widget::Image
