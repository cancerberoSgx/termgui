require_relative '../src/widget/button'
require_relative '../src/screen'
require_relative '../src/log'

class InputEvent < NodeEvent
  attr_accessor :value
  def initialize(target, value = target.value, original_event = nil)
    super 'input', target, original_event
    @value = value
  end
end

class InputBox < Button
  attr_accessor :value

  def initialize(**args)
    super
    @value = args[:value] || ''
    @key_listener = nil
    install(:input)
    install(:change)
    install(:escape)
    on(:action) do
      @key_listener = proc { |e| on_key e }
      root_screen.event.add_any_key_listener @key_listener
      on('change', args[:change]) if args[:change]
      on('input', args[:input]) if args[:input]
      on('escape', args[:escape]) if args[:escape]
    end
  end

  def on_key(event)
    if !get_attribute('focused')
      trigger('change', value: @value, target: self)
      root_screen.event.remove_any_key_listener @key_listener
    elsif event.key == 'escape'
      trigger('escape', target: self)
      root_screen.event.remove_any_key_listener @key_listener
    elsif event.key == 'backspace'
      on_input @value.slice(@value.length - 1, 1)
    elsif alphanumeric? event.key
      on_input @value + event.key
    end
  end

  protected

  def on_input(value)
    @value = value
    trigger(:value, value)
    self.text = @value
    update_width
    root_screen.clear
    root_screen.render
    trigger('input', target: self, value: @value)
  end
end

def test1
  s = Screen.new
  s.install_exit_keys
  s.append_child Button.new(x: 2, y: 2, text: 'button')
  input = s.append_child Label.new(x: 12, y: 8, text: 'input: ')
  s.append_child InputBox.new(
    x: 12, y: 2, text: 'text',
    input: proc { |e|
             input.text = 'input: ' + e.value
             input.render
           },
    escape: proc {
      input.text = 'escape'
      input.render
    }
  )
  s.start
end
test1
