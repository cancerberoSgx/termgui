# obsoleted by src/tco

# color enumerations and utilities. See http://ascii-table.com/ansi-escape-sequences.phpsss
require_relative 'key'

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

def color_names
  %w[black red green yellow blue magenta cyan white]
end

def random_color
  color_names.sample
end

def color_text(content, fg = nil, bg = nil)
  colored = color(fg, bg)
  colored << content
  colored << "#{CSI}0m"
end

def color(fg = nil, bg = nil)
  colored = ''
  colored << color_to_escape(fg, 30) if fg
  colored << color_to_escape(bg, 40) if bg
end

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
