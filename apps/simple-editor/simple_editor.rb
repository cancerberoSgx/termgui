require_relative '../src/termgui'

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