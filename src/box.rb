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

def boxes
  BOXES
end

def draw_box(width: 0, height: 0, style: :single, content: ' ')
  box = BOXES[style ? style.to_sym : :single]
  lines = []

  (0..height - 1).each do |y|
    line = []
    (0..width - 1).each do |x|
      line .push( if y.zero? && x.zero?
                box[:topLeft]
              elsif y == height - 1 && x.zero?
                box[:bottomLeft]
              elsif y.zero? && x == width - 1
                box[:topRight]
              elsif y == height - 1 && x == width - 1
                box[:bottomRight]
              elsif y == height - 1 || y.zero?
                box[:horizontal]
              elsif x == width - 1 || x.zero?
                box[:vertical]
              else
                content
              end
      )
    end
    lines.push(line.join(''))
  end
  lines
end
