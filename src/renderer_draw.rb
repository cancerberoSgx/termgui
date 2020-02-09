require 'chunky_png'

# takes care of drawing shapes. Based on Image (uses chunky_png Canvas)
# TODO: we should use TermGui::Image and not ChunkyPNG's so we add value there too
module RendererDraw
  def circle(x: nil, y: nil, radius: nil, stroke_ch: ' ', stroke: nil, fill: nil, fill_ch: stroke_ch)
    canvas = draw_canvas
    canvas.circle(x, y, radius, ChunkyPNG::Color::BLACK, ChunkyPNG::Color::WHITE)
    radius = []
    canvas.height.times do |y2|
      canvas.width.times do |x2|
        if canvas[x2, y2] == ChunkyPNG::Color::BLACK && stroke
          radius.push text(x: x2, y: y2, text: stroke_ch, style: stroke)
        elsif canvas[x2, y2] == ChunkyPNG::Color::WHITE && fill
          radius.push text(x: x2, y: y2, text: fill_ch, style: fill)
        end
      end
    end
    radius.join
  end

  private

  def draw_canvas
    # TODO: reuse the canvas
    ChunkyPNG::Canvas.new(width, height, ChunkyPNG::Color::TRANSPARENT)
  end
end
