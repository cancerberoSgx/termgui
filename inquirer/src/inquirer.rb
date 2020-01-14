require_relative '../../src/screen'

class AbstractInquirer
  def initialize(height: nil, on_answer: proc { |answer| answer })
    @screen = Screen.new
    @on_answer = on_answer
    # install
    render
  end

  # def install
  #   @screen.install_exit_keys
  # end

  def render
    @screen.event.add_key_listener('q') { @on_answer.call(3); stop }
    @screen.text(2, 2, 'AbstractInquirer (press q to quit)')
  end

  def start
    @screen.start(clean: true)
  end

  def stop
    @screen.destroy
  end
end

class SelectInquirer < AbstractInquirer
  def install
    super
  end
end

def inquire(question, &block)
  the_block = block_given? ? block : question[:answer]
  throw 'Block not given' if the_block == nil
  if question.type == 'select'

  else
    throw 'Type not implemented'
  end
end
