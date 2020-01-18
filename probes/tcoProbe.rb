# require "tco"
require_relative '../src/color'
require_relative 'tco/colouring'
require_relative 'tco/config'

config = Tco::Config.new
colouring = Tco::Colouring.new config
style = Tco::Style.new('red', 'blue', true, true)
puts colouring.decorate('KJSDHFKJH', style)
color = Tco::Colour.new [222, 111, 11]
p color

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