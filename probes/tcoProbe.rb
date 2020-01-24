# require "tco"
require_relative '../src/style'
require_relative '../src/tco/colouring'
require_relative '../src/tco/config'

config = Tco::Config.new
colouring = Tco::Colouring.new config
# style1 = Tco::Style.new('red', 'blue', true, true)
style2 = TermGui::Style.new(fg: 'red', bg: 'blue', bold: false)
style3 = TermGui::Style.new(fg: '#33aa44', bg: '#333399', bold: true)
# p colouring.decorate('KJSDHFKJH', style3)
# p colouring.decorate('', style3)
# puts 'seba'
def print_style(style, colouring)
  s = colouring.decorate('__', style)
  s = s.slice(0, s.length - 4 - 2)
  s
end

def close_style(colouring)
  colouring.decorate('', TermGui::Style.new(fg: 'red', bg: 'red', bold: true, underline: true))
end

puts colouring.decorate('style2', style2)
puts colouring.decorate('style3', style3)
puts colouring.decorate('style2', style2)
puts colouring.decorate('style3', style3)
puts colouring.decorate('style2', style2)

puts print_style(style2, colouring) + 'seba' + close_style(colouring)
puts print_style(style3, colouring) + 'seba' + close_style(colouring)
# puts close_style(colouring)
style3.bold = false
puts print_style(style3, colouring) + 'seba'

# puts 'seba'
# p style1, style2
# color = Tco::Colour.new [222, 111, 11]
# p color

# # puts 'seba'
# # puts Tco::fg("#ff0000", 'ass')
# # p Tco::fg("#ff0000", 'ass')
# def hex_color(fg = nil, bg = nil)
# end
# s = Tco::fg("#ff0000", '__')
# p s
# s.slice!(0,1)
# i = s.index '__'
# s.slice!(i, s.length - i)
# p s

# # puts  Tco::fg("red", Tco::bg("blue"), 'sebbebebe')
# # puts s.inspect
# # p Tco::fg("#ff0000", '__')

# # /g/.match
# # puts 'seba'

# # rainbow = ["#622e90", "#2d3091", "#00aaea", "#02a552", "#fdea22", "#eb443b", "#f37f5a"]
# # 10.times do
# #   rainbow.each { |colour|
# #   print "seba".bg colour
# #   # print 'seba'
# # }
# # end

# # # The standard interface
# # p Tco::fg("#ff0000", Tco::bg("#888888", Tco::bright("London")))
# puts Tco::fg("#ff0000", Tco::bg("#888888", 'LONDON'))
# puts Tco::fg("red", Tco::bg("blue", 'LONDON'))
# # puts Tco::fg("rgb(100,222,66)", Tco::bg("rgb(122, 12, 12)", 'LONDON'))
# # puts Tco::underline "Underground"

# # # The String object extension
# # puts "London".fg("#ff0000").bg("#888888").bright
# # puts 'seba'
# # puts "Underground".underline

# # # Using predefined style
# # # puts "London".style "alert"
# # # puts Tco::style "alert", "Underground"
