# frozen_string_literal: true

require_relative '../src/screen'

s = Screen.new width: 12, height: 8
x = 0
s.set_timeout(0.1, proc { 
  p 'timeout'
  s.destroy
 })
s.add_listener(:destroy, proc {
  print 'destroyed'
  x = 1
})
s.add_listener('destroy', proc {
  print 'destroyed'
  x = 1
})
# assert_equal 1, x
s.start