require_relative "emitter"
require_relative "key"

class FocusManager < Emitter
  def initialize(root: nil,
                 input: nil,
                 keys: { next: "tab", prev: "S-tab" },
                 focus_first: true)
    throw "root Element and input InputManager are required" unless root && input
    @root = root
    @keys = keys
    @input = input
    focusables.each { |n| n.set_attribute(:focused, false) }
    @focused = @root.query_one_by_attribute(:focusable, true)
    on(:focus)
    if @focused
      @focused.set_attribute(:focused, true)
    else
      # throw "No focusable elements found"
    end
    @input.subscribe "key", Proc.new { |e|
      if e.key == name_to_char(keys[:next])
        focus_next
      elsif e.key == name_to_char(keys[:prev])
        focus_prev
      end
    }
  end

  def focusables
    @root.query_by_attribute(:focusable, true)
  end

  def focused
    @focused
  end

  # focus next focusable node
  def focus_next
    i = focusables.index(@focused) || 0
    new_i = i == focusables.length - 1 ? 0 : i + 1
    set_focused focusables[new_i]
  end

  # focus previous focusable node
  def focus_prev
    i = focusables.index(@focused) || 0
    new_i = i == 0 ? focusables.length - 1 : i - 1
    set_focused focusables[new_i]
  end

  def set_focused(focused)
    previous = @focused
    @focused.set_attribute(:focused, false) if @focused
    @focused = focused
    @focused.set_attribute(:focused, true)
    emit :focus, { focused: @focused, previous: previous }
  end
end
