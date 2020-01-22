require_relative '../../src/termgui'

def main
  screen = TermGui::Screen.new
  screen.install_exit_keys
  ed = screen.append_child Editor.new(value: 'Welcome to this\nhumble editor', x: 0.2, width: 0.5, height: 0.5, y: 0.2, cursor_y: 0, cursor_x: 0)
  screen.event.add_key_listener('v') do
    ed.disable
    # TODO: there is a problem when the modal is opened and I keep pressing 'v'.. this listener will be called several times
    screen.set_timeout do
      TermGui::Widget::Modal.open(screen: screen, title: 'value', content: ed.value, on_close: proc do
        screen.set_timeout {ed.enable}
      end)
    end
  end
  screen.start
end

class Editor < TermGui::Element
  def initialize(**args)
    super
    @args = args
  end

  def render(screen)
    super
    unless @editor
      @editor = TermGui::EditorBase.new(text: @args[:value] || @text || '', screen: screen, x: abs_content_x, y: abs_content_y, cursor_x: @args[:cursor_x], cursor_y: @args[:cursor_y])
      @editor.enable(false)
    end
    @editor.x = abs_content_x
    @editor.y = abs_content_y
    @editor.render
  end

  def value
    @editor&.text || ''
  end

  def enable
    @editor.enable
  end

  def enabled
    @editor.enabled
  end

  def disable
    @editor.disable
  end
end

main
# 
#  p '123'[-1..1]
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
