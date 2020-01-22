require_relative '../../src/termgui'

def main
  screen = TermGui::Screen.new
  screen.append_child Editor.new(text: 'hello world\how are you?', x: 0.2)
  screen.set_timeout{

  }
  screen.start
end

class Editor < TermGui::Element
  def initialize(**args)
    super
    @editor = TermGui::EditorBase.new(text: args[:text], screen: root_screen, x: abs_content_x, y: abs_content_y, cursor_x: args[:cursor_x], cursor_y: args[:cursor_y])
  end
  
end

# s = Screen.new(width: 12, height: 7, silent: true)
# s.append_child Element.new(x: 7, y: 3, width: 7, height: 12, text: 'hello', ch: '·', style: { border: Border.new, padding: Bounds.new(top: 1, left: 2) })
# s.clear
# s.render
# # s.renderer.print_dev_stdout

# s.offset.left=5
# # s.offset = Offset.new(left: 2, top: 0)
# s.clear
# s.render
# # s.renderer.print_dev_stdout
# # p s.offset.left
# # p (1..3).to_a.sample

# def f(*a)
#   arr=[1,2,3]
#   arr.insert(1, *a)
#   p arr
# end
# f(8,8,8)
# p [1, 2].insert(1, 4, 5,6)