# frozen_string_literal: true

require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/screen'
require_relative '../src/util'

class ScreenTest < Test::Unit::TestCase
  def test_renderer
    s = Screen.new width: 5, height: 6
    r = s.renderer
    assert_equal r.buffer.length, 6
    assert_equal r.buffer[0].length, 5
  end

  def test_destroy
    s = Screen.new width: 12, height: 8
    x = 0
    s.set_timeout(0.1, proc { s.destroy })
    s.add_listener(:destroy, proc {
      print 'destroyed'
      x = 1
    })
    assert_equal 0, x
    s.start
    assert_equal 1, x

    s = Screen.new width: 12, height: 8
    x = 0
    s.set_timeout(0.1, proc { s.destroy })
    s.add_listener('destroy', proc {
      print 'destroyed'
      x = 1
    })
    assert_equal 0, x
    s.start
    assert_equal 1, x
  end

  def test_rect_clear
    s = Screen.new width: 12, height: 7
    s.rect(x: 1, y: 2, width: 3, height: 2, ch: 'f')
    s.rect(x: 6, y: 3, width: 4, height: 3, ch: 'g')
    assert_equal ['            ',
                  '            ',
                  ' fff        ',
                  ' fff  gggg  ',
                  '      gggg  ',
                  '      gggg  ',
                  '            '],
                 s.renderer.print_rows
    s.clear
    assert_equal ['            ',
                  '            ',
                  '            ',
                  '            ',
                  '            ',
                  '            ',
                  '            '],
                 s.print.split('\n')
  end
end
