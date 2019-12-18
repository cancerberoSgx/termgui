# frozen_string_literal: true

CSI = "\e["
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

def color(content, foreground = nil, background = nil)
  colored = color_name_to_escape_code(foreground, 30) if foreground
  colored << color_name_to_escape_code(background, 40) if background
  colored << content
  colored << "#{CSI}0m"
end

def color_name_to_escape_code(name, layer)
  short_name = name.to_s.sub(/\Abright_/, '')
  color = COLORS.fetch(short_name.to_sym)
  escape = "#{CSI}#{layer + color}"
  escape << ';1' if short_name.size < name.size
  escape << 'm'
  escape
end

[['C', :red],
 ['O', :bright_red],
 ['L', :bright_yellow],
 ['O', :bright_green],
 ['R', :bright_blue],
 ['S', :blue],
 ['!', :bright_magenta]].each do |char, color|
  $stdout.write color(char, color, :white)
end

puts color('hello', :red)
