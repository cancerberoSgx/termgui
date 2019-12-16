class FocusManager
  def initialize(root: nil, focus_first: true)
    @root = root
    reset
    @focused = @root.query_one_by_attribute(:focusable, true)
    if @focused
      @focused.set_attribute(:focused, true)
    else
      # throw "No focusable elements found"
    end
  end

  def reset
    focusables.each { |n| n.set_attribute(:focused, false) }
  end

  def focusables
    @root.query_by_attribute(:focusable, true)
  end

  def focused
    @focused
  end

  # focus next focusable node
  def next
    i = focusables.index(@focused) || 0
    new_i = i == focusables.length - 1 ? 0 : i + 1
    @focused.set_attribute(:focused, false)
    @focused = focusables[new_i]
    @focused.set_attribute(:focused, true)
  end
end
