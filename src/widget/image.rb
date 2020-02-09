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
      attr_accessor :pan_x, :pan_y, :zoom
      def initialize(**args)
        super
        @name = 'image'
        @src = args[:src]
        @use_bg = args[:use_bg] == nil ? true : args[:use_bg]
        @use_fg = args[:use_fg] == nil ? false : args[:use_fg]
        @transparent_color = args[:transparent_color]
        @ignore_alpha = args[:ignore_alpha]
        @zoom = args[:zoom] || 1.0
        @pan_x = args[:pan_x] || 0.0
        @pan_y = args[:pan_y] || 0.0
        @chs = args[:chs] || [get_attribute('ch')||' ']
      end

      def image
        if !@image && @src
          @image = @src.is_a?(String) ? TermGui::Image.new(@src) : @src
        end
        if @image
          factor = (@image.width - abs_content_width) < (@image.height - abs_content_height) ?
          @zoom * @image.width.to_f / abs_content_width.to_f :
            @zoom * @image.height.to_f / abs_content_height.to_f
          @resized_image = @image.scale(
            width: (@image.width.to_f / factor).to_i,
            height: (@image.height.to_f / factor).to_i
          )
          # root_screen.text(text: factor.to_s)
          if @pan_x + @pan_y > 0
            @resized_image = @resized_image.crop(
              x: (@resized_image.width.to_f * @pan_x).to_i,
              y: (@resized_image.height.to_f * @pan_y).to_i,
              width: (@resized_image.width.to_f - @resized_image.width.to_f * @pan_x).to_i,
              height: (@resized_image.height.to_f - @resized_image.height.to_f * @pan_y).to_i
            )
          end
      end
        @image
      end

      def render_self(screen)
        [
          super,
          image ? screen.image(
            x: abs_content_x,
            y: abs_content_y,
            w: abs_content_width - abs_content_x,
            h: abs_content_height - abs_content_y,
            transparent_color: !@ignore_alpha ? TermGui.to_rgb(@transparent_color || final_style.bg || '#000000') : nil,
            image: @resized_image,
            bg: @use_bg,
            fg:  @use_fg,
            style: final_style,
            ch: @chs
          ) : ''
        ].join('')
      end

      def src=(v)
        @src = v
        @image = nil
        refresh
      end

      def refresh(force_render = false)
        @resized_image = nil
        image
        if force_render
          clear
          render
        end
      end
    end
  end
end

Image = TermGui::Widget::Image
