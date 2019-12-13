# color enumerations and utilities

COLORS = {
  black: 0,
  red: 1,
  green: 2,
  yellow: 3,
  blue: 4,
  magenta: 5,
  cyan: 6,
  white: 7,
}

def colorNames
  ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]
end

# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
ATTRIBUTES = {
  normal: 0,

  bold: 1,
  boldOff: 22,

  faint: 2,
  faintOff: 22,

  italic: 3,
  italicOff: 23,

  underline: 4,
  underlineOff: 24,

  blink: 5,
  slowBlink: 5,
  rapidBlink: 6,
  blinkOff: 25,
  slowBlinkOff: 25,
  rapidBlinkOff: 25,

  inverse: 7,
  inverseOff: 27,

  defaultForeground: 39,
  defaultBackground: 49,

  invisible: 8,
  invisibleOff: 28,

  fraktur: 20,
  frakturOff: 23,

  framed: 51,
  encircled: 52,
  ovelrined: 53,

  framedOff: 54,
  encircledOff: 54,
}

def randomColor
  colorNames.sample
end

def colorText(content, fg = nil, bg = nil)
  colored = color(fg, bg)
  colored << content
  colored << "#{CSI}0m"
end

def color(fg = nil, bg = nil)
  colored = ""
  colored << colorToEscape(fg, 30) if fg
  colored << colorToEscape(bg, 40) if bg
end

def colorToEscape(name, layer)
  short_name = name.to_s.sub(/\Abright_/, "")
  color = COLORS.fetch(short_name.to_sym)
  escape = "#{CSI}#{layer + color}"
  escape << ";1" if short_name.size < name.size
  escape << "m"
  escape
end
