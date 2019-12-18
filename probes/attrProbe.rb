# frozen_string_literal: true

a = { x: 0, y: 0, width: 1, height: 1 }
a.each_key { |key| print key.to_s }

CSI = "\e["

# Fill Rectangular Area (DECFRA).
# P c is the character to use.
# P t ; P l ; P b ; P r denotes the rectangle.

# CSI P c ; P t ; P l ; P b ; P r $ x

s = "#{CSI}-;1;2;3;2$x"

$stdout.write s
