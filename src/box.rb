BOXES = {
  single: {
    topLeft: "┌",
    topRight: "┐",
    bottomRight: "┘",
    bottomLeft: "└",
    vertical: "│",
    horizontal: "─",
  },
  double: {
    topLeft: "╔",
    topRight: "╗",
    bottomRight: "╝",
    bottomLeft: "╚",
    vertical: "║",
    horizontal: "═",
  },
  round: {
    topLeft: "╭",
    topRight: "╮",
    bottomRight: "╯",
    bottomLeft: "╰",
    vertical: "│",
    horizontal: "─",
  },
  bold: {
    topLeft: "┏",
    topRight: "┓",
    bottomRight: "┛",
    bottomLeft: "┗",
    vertical: "┃",
    horizontal: "━",
  },
  single_double: {
    topLeft: "╓",
    topRight: "╖",
    bottomRight: "╜",
    bottomLeft: "╙",
    vertical: "║",
    horizontal: "─",
  },
  double_single: {
    topLeft: "╒",
    topRight: "╕",
    bottomRight: "╛",
    bottomLeft: "╘",
    vertical: "│",
    horizontal: "═",
  },
  classic: {
    topLeft: "+",
    topRight: "+",
    bottomRight: "+",
    bottomLeft: "+",
    vertical: "|",
    horizontal: "-",
  },
}

# p BOXES.keys

def boxes
  BOXES
end

def draw_box(width, height, style = :single, content = " ")
  box = BOXES[style.to_sym]
  lines = []
  (0..height - 1).each { |y|
    line = ""
    (0..width - 1).each { |x|
      if y == 0 && x == 0
        line += box[:topLeft]
      elsif y == height - 1 && x == 0
        line += box[:bottomLeft]
      elsif y == 0 && x == width - 1
        line += box[:topRight]
      elsif y == height - 1 && x == width - 1
        line += box[:bottomRight]
      elsif y == height - 1 || y == 0
        line += box[:horizontal]
      elsif x == width - 1 || x == 0
        line += box[:vertical]
      else
        line += content
      end
    }
    lines.push(line)
  }
  lines
end
