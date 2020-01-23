# temporary modal window solution.
# TODO: reimplement this using actual screen children elements and remove it for closing

require_relative '../screen'
require_relative '../util'
require_relative '../element'
require_relative '../style'
require_relative '../log'
require_relative '../widget/button'
require_relative '../widget/label'

@modal_open = false
def open_modal(
  screen: nil,
  title: 'Modal',
  content: Label.new(text: 'Content'),
  buttons: [
    Button.new(text: 'OK', action: proc { close_modal screen })
  ],
  on_close: nil
)
  return if @modal_open

  screen.set_timeout do
    # first time called we set up 'c' key for closing modals
    screen.event.add_key_listener('c', proc {
      close_modal screen
      on_close&.call
    })

    @modal_open = true

    content = (content.instance_of? String) ? Label.new(text: content) : content
    screen.rect(x: 2, y: 2, width: [content.width, '(press c to close)'.length].max + 3, height: 7 + content.height, ch: ' ')
    screen.text(x: 3, y: 3, text: title)
    screen.text(x: 3, y: 4, text: '(press c to close)')
    content.x = 3
    content.y = 5
    content.render screen
    buttons.each do |b|
      b.y = content.height + 6
      b.x = 3
      b.render screen
    end
    # screen.input.grab(proc { |e|
    #   # log 'hello'
    #   # screen.destroy
    #   if e.key == 'q'
    #     screen.input.ungrab
    #     # close_modal screen
    #     screen.text 3, 3, 'UNGRAB'
    #   end
    #   # screen.text 2, 2, "grab #{e.key}"
    # })
  end
end

def close_modal(screen)
  screen.render
  @modal_open = false
  # @close_block&.call
end

module TermGui
  module Widget
    class Modal
      def self.open(**args)
        open_modal(args)
      end
    end
  end
end
