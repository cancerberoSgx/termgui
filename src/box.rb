# frozen_string_literal: true

BOXES = {
  single: {
    topLeft: '┌',
    topRight: '┐',
    bottomRight: '┘',
    bottomLeft: '└',
    vertical: '│',
    horizontal: '─'
  },
  double: {
    topLeft: '╔',
    topRight: '╗',
    bottomRight: '╝',
    bottomLeft: '╚',
    vertical: '║',
    horizontal: '═'
  },
  round: {
    topLeft: '╭',
    topRight: '╮',
    bottomRight: '╯',
    bottomLeft: '╰',
    vertical: '│',
    horizontal: '─'
  },
  bold: {
    topLeft: '┏',
    topRight: '┓',
    bottomRight: '┛',
    bottomLeft: '┗',
    vertical: '┃',
    horizontal: '━'
  },
  single_double: {
    topLeft: '╓',
    topRight: '╖',
    bottomRight: '╜',
    bottomLeft: '╙',
    vertical: '║',
    horizontal: '─'
  },
  double_single: {
    topLeft: '╒',
    topRight: '╕',
    bottomRight: '╛',
    bottomLeft: '╘',
    vertical: '│',
    horizontal: '═'
  },
  classic: {
    topLeft: '+',
    topRight: '+',
    bottomRight: '+',
    bottomLeft: '+',
    vertical: '|',
    horizontal: '-'
  }
}.freeze

# p BOXES.keys

def boxes
  BOXES
end

def draw_box(width, height, style = :single, content = ' ')
  box = BOXES[style.to_sym]
  lines = []
  (0..height - 1).each do |y|
    line = ''
    (0..width - 1).each do |x|
      line += if y == 0 && x == 0
                box[:topLeft]
              elsif y == height - 1 && x == 0
                box[:bottomLeft]
              elsif y == 0 && x == width - 1
                box[:topRight]
              elsif y == height - 1 && x == width - 1
                box[:bottomRight]
              elsif y == height - 1 || y == 0
                box[:horizontal]
              elsif x == width - 1 || x == 0
                box[:vertical]
              else
                content
              end
    end
    lines.push(line)
  end
  lines
end
