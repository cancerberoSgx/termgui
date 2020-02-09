# temporary modal window solution.
# TODO: reimplement this using actual screen children elements and remove it for closing

require_relative '../screen'
require_relative '../util'
require_relative '../element'
require_relative '../style'
require_relative '../log'
require_relative '../widget/button'
require_relative '../widget/col'
require_relative '../widget/label'

# @modal_open = false

def open_modal(
  screen: nil,
  title: 'Modal',
  content: Label.new(text: 'Content'),
  on_close: nil
)
  modal = screen.query_one_by_attribute('modal-widget', true)
  return if modal

    content = content.is_a?(String) ? Label.new(text: content) : content
  # content.x= 1
  # content.y = 2
  # content.height= 0.6
  # content.width= 0.8
  modal = screen.append_child Element.new(height: 0.9, width: 0.6, attributes: {'modal-widget': true}, children: [
    Label.new(text: title, style: {bold: true}, x: 1, y: 1),
    content,
    # Element.new(x: 1, y: 2, height: 0.8, width: 0.8, text: content)
    Button.new(text: 'close', y: 0.8, x: 1, action: proc {
      modal.remove
      screen.clear
      screen.render
      on_close && on_close.call
    })
  ])

  modal.render

  
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
