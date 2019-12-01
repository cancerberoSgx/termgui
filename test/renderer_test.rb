require_relative '../src/renderer'
  require "test/unit"
include Test::Unit::Assertions
class RendererTest < Test::Unit::TestCase
  def test_rect_stub
    s=`ruby test/renderer_test_rect.rb`
    assert_include s, 
    "\e[1;2Hllllllll" + 
    "\e[2;2Hllllllll" + 
    "\e[3;2Hllllllll" + 
    "\e[4;2Hllllllll" + 
    "\e[5;2Hllllllll", 
    'should print a rectangle with Ls'
  end  
  def test_rect
    r=Renderer.new 
    s=r.rect 2,1,3,2,'x'
    assert_equal s, "\e[1;2Hxxx\e[2;2Hxxx"
    # print s
  end
  def test_buffer
    r=Renderer.new 
    r.rect 2,1,3,2,'x'
    # print r.buffer.inspect
  end
end

  