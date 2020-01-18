# # adapted from tco
# # tco - terminal colouring application and library
# # Copyright (c) 2013, 2014 Radek Pazdera

# module Tco
#   class Style
#     attr_accessor :fg, :bg, :bright, :underline

#     def initialize(fg=nil, bg=nil, bright=false, underline=false)
#       @fg = fg
#       @bg = bg
#       @bright = bright
#       @underline = underline
#     end

#     def to_a
#       [@fg, @bg, @bright, @underline]
#     end

#     def to_h
#       {:fg => @fg, :bg => @bg, :bright => @bright, :underline => @underline}
#     end

#     def to_ary
#       to_a
#     end

#     def ==(o)
#       @fg == o.fg && @bg == o.bg && @bright == o.bright && @underline == o.underline
#     end
#   end
# end
