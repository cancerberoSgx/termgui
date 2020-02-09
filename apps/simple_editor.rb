require_relative '../src/termgui'
require_relative '../src/widget/modal'

def main
  screen = TermGui::Screen.new
  screen.append_child Button.new(text: 'click', x: 0, y: 8)
  ed = screen.append_child Editor.new(
    value: 'Welcome to this\nhumble editor',
    x: 0.2, width: 0.5, height: 0.5, y: 0.2, cursor_y: 0, cursor_x: 0,
    style: Style.new(border: Border.new, padding: Bounds.new(top: 1, left: 2))
  )
  screen.event.add_key_listener('v') do
    ed.disable
    screen.set_timeout do
      TermGui::Widget::Modal.open(screen: screen, title: 'value', content: ed.value, on_close: proc do
        screen.set_timeout { ed.enable }
      end)
    end
  end
  screen.start
end

class Editor < TermGui::Element
  include TermGui::Enterable
  def modal_log(screen, *args)
    s = args.nil? ? 'nil' : args.to_s
    s = "------\n#{s}\n"
    open_modal(screen: screen, content: s, title: 'log')
    screen.set_timeout(5) do
      close_modal(screen)
    end
  end

  def initialize(**args)
    super
    @args = args
    on('enter') do
      @editor ||= TermGui::EditorBase.new(
        managed: true, text: @args[:value] || @text || '', screen: root_screen,
        x: abs_content_x, y: abs_content_y, cursor_x: @args[:cursor_x] || 0, cursor_y: @args[:cursor_y] || 0
      )
      @editor.x = abs_content_x
      @editor.y = abs_content_y
      @editor.enable(true)
      # enable

      # @editor.render
    end
    on(%w[blur escape focus]) do |_e|
      disable
      # log('blur&escape '+e.name)
    end
  end

  def handle_key(event)
    handled = super
    if !handled
      @editor.handle_key event
      true
    else
      false
    end
  end

  def default_style
    s = super
    s.border = Border.new
    s.bg = 'white'
    s.fg = 'blue'
    s.focus.fg = 'green'
    s.focus.bg = 'blue'
    s.padding = Bounds.new(top: 1, left: 2, bottom: 1, right: 2)
    s
  end

  def value
    @editor&.text || ''
  end

  def value=(value)
    @editor&.text = value
  end

  def enable
    @editor&.enable
  end

  def enabled
    @editor&.enabled
  end

  def disable
    @editor&.disable
  end
end

main
