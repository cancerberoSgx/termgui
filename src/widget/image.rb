require_relative '../image'
require_relative '../element'

module TermGui
  module Widget
    # analog to HTMLImageElement
    class Image < Element
      def initialize(**args)
        super
        @name = 'image'
        @src = args[:src]
        @use_bg = args[:use_bg]==nil ? true : args[:use_bg]
        @use_fg = args[:use_fg]==nil ? false : args[:use_fg]
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
        [super(screen) || '',
         image ? screen.image(
           x: abs_content_x,
           y: abs_content_y,
           image: image,
           bg: @use_bg,
           fg:  @use_fg,
           style: final_style,
           ch: get_attribute('ch')
         ) : ''].join('')
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

require_relative '../screen'
require_relative '../util'
require_relative 'button'
img = nil
s = Screen.new(
  children: [
    Button.new(text: 'hello', x: 0.7, y: 0.6, action: proc { |e|
      img ||= Image.new(
        render_cache: true,
        x: 2,
        y: 1,
        style: Style.new(
          border: Border.new(fg: '#ee3388'),
          padding: Bounds.new(top: 0.1, left: 0.01, right: 0.1, bottom: 0.1),
          bg: '#e09988',
          bold: true
        ),
        use_bg: false,
        use_fg: true,
        width: 0.9,
        ch: '#',
        height: 0.9,
        src: '/Users/wyeworks/Documents/assets/whale4.png',
        parent: s
      )
      s.clear
      t0 = Time.now
      img.render
      text = "rendered in #{print_ms(t0)}"
      s.text(x: random_int(1, s.width - 20), y: random_int(1, s.height - 3), text: text)
      e.target.x = random_int(1, s.width - 20)
      e.target.y = random_int(1, s.height - 3)
      e.target.text = text
      e.target.render
    })
  ]
)
s.start
