
# // As it happens, comparing how similar two colors are is really hard. Here is
# // one of the simplest solutions, which doesn't require conversion to another
# // color space, posted on stackoverflow[1]. Maybe someone better at math can
# // propose a superior solution.
# // [1] http://stackoverflow.com/questions/1633828

# function colorDistance(r1, g1, b1, r2, g2, b2) {
#   return Math.pow(30 * (r1 - r2), 2)
#     + Math.pow(59 * (g1 - g2), 2)
#     + Math.pow(11 * (b1 - b2), 2);
# }



# // This might work well enough for a terminal's colors: treat RGB as XYZ in a
# // 3-dimensional space and go midway between the two points.
# exports.mixColors = function(c1, c2, alpha) {
#   // if (c1 === 0x1ff) return c1;
#   // if (c2 === 0x1ff) return c1;
#   if (c1 === 0x1ff) c1 = 0;
#   if (c2 === 0x1ff) c2 = 0;
#   if (alpha == null) alpha = 0.5;

#   c1 = exports.vcolors[c1];
#   var r1 = c1[0];
#   var g1 = c1[1];
#   var b1 = c1[2];

#   c2 = exports.vcolors[c2];
#   var r2 = c2[0];
#   var g2 = c2[1];
#   var b2 = c2[2];

#   r1 += (r2 - r1) * alpha | 0;
#   g1 += (g2 - g1) * alpha | 0;
#   b1 += (b2 - b1) * alpha | 0;

#   return exports.match([r1, g1, b1]);
# };





# the rest is obsoleted by src/tco

# color enumerations and utilities. See http://ascii-table.com/ansi-escape-sequences.phpsss
require_relative 'key'

# obsolete
COLORS = {
  black: 0,
  red: 1,
  green: 2,
  yellow: 3,
  blue: 4,
  magenta: 5,
  cyan: 6,
  white: 7
}.freeze

# obsolete
def color_names
  %w[black red green yellow blue magenta cyan white]
end

# obsolete
def random_color
  color_names.sample
end

# obsolete
def color_text(content, fg = nil, bg = nil)
  colored = color(fg, bg)
  colored << content
  colored << "#{CSI}0m"
end

# obsolete
def color(fg = nil, bg = nil)
  colored = ''
  colored << color_to_escape(fg, 30) if fg
  colored << color_to_escape(bg, 40) if bg
end

# obsolete
def color_to_escape(name, layer)
  short_name = name.to_s.sub(/\Abright_/, '')
  color = COLORS.fetch(short_name.to_sym)
  escape = "#{CSI}#{layer + color}"
  escape << ';1' if short_name.size < name.size
  escape << 'm'
  escape
end

# # https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# ATTRIBUTES = {
#   normal: 0,

#   bold: 1,
#   boldOff: 22,

#   faint: 2,
#   faintOff: 22,

#   italic: 3,
#   italicOff: 23,

#   underline: 4,
#   underlineOff: 24,

#   blink: 5,
#   slowBlink: 5,
#   rapidBlink: 6,
#   blinkOff: 25,
#   slowBlinkOff: 25,
#   rapidBlinkOff: 25,

#   inverse: 7,
#   inverseOff: 27,

#   defaultForeground: 39,
#   defaultBackground: 49,

#   invisible: 8,
#   invisibleOff: 28,

#   fraktur: 20,
#   frakturOff: 23,

#   framed: 51,
#   encircled: 52,
#   overlined: 53,

#   framedOff: 54,
#   encircledOff: 54
# }.freeze

# # Usage: screen.write attributes(blink: true).
# # Attributes supported: bold, inverse, blink, slowBlink, rapidBlink, invisible, fraktur, framed, encircled, normal,
# # italic, underline, faint
# #
# # Esc[Value;...;Valuem  Set Graphics Mode:
# # Calls the graphics functions specified by the following values.
# # These specified functions remain active until the next occurrence of this escape sequence. Graphics mode changes the
# # colors and attributes of text (such as bold and underline) displayed on the screen
# def attributes(**args)
#   output = []
#   args.keys.each do |key|
#     if args[key] == true
#       output.push ATTRIBUTES[key].to_s
#     elsif args[key] == false
#       output.push ATTRIBUTES[:blinkOff].to_s if key == :blink
#       output.push "#{CSI}#{ATTRIBUTES[:boldOff]}" if key == :bold
#       # TODO: the rest
#     end
#   end
#   # p output
#   !output.empty? ? "#{CSI}#{output.join(';')}m" : ''
# end
