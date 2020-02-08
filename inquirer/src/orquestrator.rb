require_relative '../../src/screen'
require_relative '../../src/widget/button'
require_relative '../../src/widget/col'
require_relative '../../src/log'

class Orquestrator
  def start
    this.screen = Screen.new
    this.screen.focus.keys[:next].push('top')
    this.screen.focus.keys[:prev].push('down')
    this.screen.install_exit_keys
  end
end

def test
  screen.append_child SelectOne.new(
    width: 0.999,
    height: 0.999,
    options: [
      { value: 'green', label: 'Green', selected: true },
      { value: 'red', label: 'Red' }
    ],
    select: proc { |value, selected|
      log value + selected.to_s
    }
  )
  screen.render
  screen.event.add_key_listener('c') do
    screen.empty
    screen.clear
    screen.render
    screen.append_child SelectOne.new(width: 0.999, height: 0.999, options: %w[
                                        hello world
                                      ])
    screen.render
  end
  screen.start
end

test
