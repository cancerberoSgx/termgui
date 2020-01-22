require 'mouse'

Mouse.current_position # => #<CGPoint x=873.2 y=345.0>

# positions can be given as an array with two points, or a CGPoint
Mouse.move_to [10, 10]
Mouse.move_to CGPoint.new(10, 10)

# optionally specify how long it should take the mouse to move
Mouse.move_to [800, 300], 0.2

Mouse.click
Mouse.double_click
Mouse.triple_click

# secondary_click and right_click are aliases to the same method
Mouse.secondary_click
Mouse.right_click

# positive number scrolls up, negative number scrolls down
Mouse.scroll 10
Mouse.scroll -10

# perform horizontal scrolling as well
# positive number scrolls left, negative number scrolls right
Mouse.horizontal_scroll 10
Mouse.horizontal_scroll -10

# optionally specify units for scroll amount, :pixel or :line
Mouse.scroll 10, :pixels
Mouse.scroll -10, :pixels

# just like a two finger double tap
Mouse.smart_magnify
Mouse.smart_magnify [600, 500]

# pinch-to-zoom
Mouse.pinch :zoom
Mouse.pinch :expand, 2

# pinch-to-unzoom
Mouse.pinch :unzoom, 2.0, 5.0
Mouse.pinch :contract, 1.0

# even perform rotation gestures!
Mouse.rotate :clockwise, 90
Mouse.rotate :counter_clockwise, 180
Mouse.rotate :cw, 360

# swipe, swipe, swipe
Mouse.swipe :up
Mouse.swipe :down
Mouse.swipe :left
Mouse.swipe :right