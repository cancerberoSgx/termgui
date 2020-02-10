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

def open_modal(
  screen: nil,
  title: Label.new(text: 'Modal'),
  content: Label.new(text: 'Content'),
  on_close: nil
)
  modal = screen.query_one_by_attribute('modal-widget', true)
  return if modal

  screen.set_timeout(0.3) do
    focused = screen.focus.focused
    focusables = screen.focus.focusables
    focusables.each { |e| e.set_attribute('focusable', false) }
    title = title.is_a?(String) ? Label.new(text: title, style: { bold: true, fg: '#001119', underline: true }, x: 1, y: 1) : title
    content = content.is_a?(String) ? Label.new(text: content, style: { wrap: true, fg: '#77aa33' }, x: 1, y: 3, height: 0.8, width: 0.9) : content
    close = Button.new(text: 'close', y: 1, x: 0.9, action: proc {
      modal.remove
      screen.clear
      screen.render
      on_close&.call
      focusables.each { |e| e.set_attribute('focusable', true) }
      focused&.focus
    })
    modal = screen.append_child Element.new(
      x: 0.2, y: 0.1,
      height: 0.9,
      width: 0.6,
      attributes: { 'modal-widget': true },
      padding: Bounds.new(top: 1, left: 2),
      style: { bg: 'white', fg: 'blue', wrap: true, border: Border.new(bg: 'red', style: 'double') },
      children: [
        title,
        close,
        content
      ]
    )
    close.focus
    modal.render
  end
end

def clode_modal(screen)
  modals = screen.query_by_attribute('modal-widget', true)
  # return unless modals.length>0
  modals.each{|modal|modal.remove}
  screen.render if modals.length>0
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
