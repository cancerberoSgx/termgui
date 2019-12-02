require_relative '../src/renderer'
require_relative '../src/util'
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
  end
  def test_print
    r2=Renderer.new 10, 7
    r2.rect 2,1,3,2,'x'
    assert_equal  r2.print, 
    "----------\\n" +
    "--xxx-----\\n" +
    "--xxx-----\\n" +
    "----------\\n" +
    "----------\\n" +
    "----------\\n" +
    "----------\\n"
  end
end
