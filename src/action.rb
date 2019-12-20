# action manager - it notifies focused elements on user input
class ActionManager
  def initialize(focus, input)
    @focus = focus
    @input = input
    @input.add_listener(:key, proc { |e| handle_key e })
  end

  def handle_key(e)
    @focus.focused&.handle_focused_input e
  end
end
