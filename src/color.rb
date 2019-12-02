COLORS = {
  black:   0,
  red:     1,
  green:   2,
  yellow:  3,
  blue:    4,
  magenta: 5,
  cyan:    6,
  white:   7
}

def colorText(content, foreground=nil, background = nil)
  colored  = color(foreground, background)
  colored << content
  colored << "#{CSI}0m"
end

def color(foreground=nil, background = nil)
  colored=''
  colored << colorToEscape(foreground, 30) if foreground
  colored << colorToEscape(background, 40) if background
end

def colorToEscape(name, layer)
  short_name = name.to_s.sub(/\Abright_/, "")
  color      = COLORS.fetch(short_name.to_sym)
  escape     = "#{CSI}#{layer + color}"
  escape    << ";1" if short_name.size < name.size
  escape    << "m"
  escape
end
