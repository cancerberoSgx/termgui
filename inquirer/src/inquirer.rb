require_relative '../../src/screen'
require_relative '../../src/widget/button'

class AbstractInquirer
  def initialize(on_answer: proc { |answer| answer })
    @screen = Screen.new
    @on_answer = on_answer
    render
  end

  def render
    @screen.event.add_key_listener('q') { @on_answer.call(3); stop }
  end

  def start
    @screen.start(clean: true)
  end

  def stop
    @screen.destroy
  end
end

class Control < Button
  def default_style
    s = super
    s.border = nil
    s.bg = 'white'
    s.fg = 'blue'
    s.focus.fg = 'green'
    s.focus.bg = 'blue'
    s
  end
end

class SelectInquirer < AbstractInquirer
  def initialize(on_answer: proc { |answer| answer }, text: 'Please select', options: [])
    super
    @options = ptions
    render
  end

  def render
    super
    @screen.text(x: 2, y: 1, text: @text) if @text
    @screen.text(x: 2, y: 2, text: 'Use arrows and enter to select. Press q to quit')
    @options.each_index{|option, i|
    text = (option.instance_of? String) ? option : (option.label||option.value||option||'').to_s
    @screen.text(x: 2, y: 3 + i, text: text)
    }
  end
end

def inquire(question, &block)
  the_block = block_given? ? block : question[:answer]
  throw 'Block not given' if the_block == nil
  if question[:type] == 'select'
    impl = SelectInquirer.new(on_answer: proc { |answer|
      p 'ANSWWEEEE', answer
      the_block.call(answer)
    })
    impl.start
  else
    throw 'Type not implemented'
  end
end

# p (''.instance_of? String), ({}.instance_of? String)

# inquire(
#   type: 'select',
#   options: [
#     { value: 'green', label: 'Green' },
#     { value: 'red', label: 'Red' }
#   ]
# ) do |answer|
#   p 'asdasdasd', answer
# end
