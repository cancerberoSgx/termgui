require_relative '../src/renderer'
  require "test/unit"
include Test::Unit::Assertions
class RendererTest < Test::Unit::TestCase
  def test_rect
    r=Renderer.new
    s=`ruby test/renderer_test_rect.rb`
    assert_include s, 
      "\e[1;2Hllllllll" + 
      "\e[2;2Hllllllll" + 
      "\e[3;2Hllllllll" + 
      "\e[4;2Hllllllll" + 
      "\e[5;2Hllllllll", 
    'should print a rectangle with Ls'
  end  
end

  