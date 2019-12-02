require_relative '../src/renderer'

height=10
width=20
buffer=[]
# print (0...height).to_a.map{|i|i*2}
# [1,2,3].map{|i|print i}
(0...height).to_a.map {|y|
  (0...width).to_a.map {|x|
    puts "#{x}, #{y}"
  }
}
#  .times{width.times {Pixel.new ' ', {} }}
# print buffer.length