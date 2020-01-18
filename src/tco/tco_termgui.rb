require_relative 'colouring'
require_relative 'config'

module TermGui
  @colouring_config = Tco::Config.new
  @colouring = Tco::Colouring.new @colouring_config

  def self.open_style(style, colouring = @colouring)
    s = colouring.decorate('__', style)
    s = s.slice(0, s.length - 4 - 2)
    s
  end

  def close_style(colouring = @colouring)
    colouring.decorate('', TermGui::Style.new(fg: 'red', bg: 'red', bold: true, underline: true))
  end

  def print(s, style)
    colouring.decorate(s, style)
  end
end

# # style1 = Tco::Style.new('red', 'blue', true, true)
# style2 = TermGui::Style.new(fg: 'red', bg: 'blue', bold: false)
# style3 = TermGui::Style.new(fg: '#33aa44', bg: '#333399', bold: true)
# # p colouring.decorate('KJSDHFKJH', style3)
# # p colouring.decorate('', style3)
# # puts 'seba'
