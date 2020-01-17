require_relative '../../src/screen'
require_relative '../../src/widget/button'
require_relative '../../src/widget/col'
require_relative '../../src/log'

class SelectEntry < Button
  def initialize(**args)
    super
    set_attribute('action-key', ' ')
  end
  def default_style
    s = super
    s.border = nil
    # s.bg = nil
    # s.fg = nil
    s
  end
end

class SelectOne < Element
  def initialize(**args)
    super
    throw "No options provided" unless args[:options]
    @multiple = args[:multiple]||false
    @options = args[:options]
    col = append_child Col.new(width: 0.8, height: 0.99, style: { bg: 'white' })
    col.append_child Label.new(text: "Please focus with TAB, select with SPACE and press ENTER when ready", width: 0.5, x: 0.2)
    @entries = @options.map{|option|
      selected = (option.instance_of? String) ? false : option[:selected]
      value = (option.instance_of? String) ? option : option[:value]
      text_only = (option.instance_of? String) ? option : (option[:label]||option[:value])
      text = "#{selected ? '[x]' : '[ ]'} #{text_only}"
      entry = col.append_child SelectEntry.new(
        text: text,
        x: 0.5,
        attributes: {selected: selected, value: value},
        action: proc { |e|
          value = e.target.get_attribute('selected') # TODO: why we cannot just  e.target.set_attribute('selected', !e.target.get_attribute('selected')) ???
          value = !value
          e.target.text = "#{value ? '[x]' : '[ ]'} #{text_only}"
          e.target.set_attribute('selected', value)
          e.target.render
          if args[:select]
            args[:select].call(e.target.get_attribute('value'), value)
          end
        }
      )
      # entry.set_attribute('selected', selected)
      entry
    }
  end
end

def test
  screen = Screen.new
  screen.focus.keys[:next].push('top')
  screen.focus.keys[:prev].push('down')
  screen.install_exit_keys

  screen.append_child SelectOne.new(
    width: 0.999,
    height: 0.999,
    options: [
      {value: 'green', label: 'Green', selected: true},
      {value: 'red', label: 'Red'}
    ],
    select: proc {|value, selected|
      log value+selected.to_s
    }
  )
  screen.render
  screen.event.add_key_listener('c'){
    screen.empty
    screen.clear
    screen.render
    screen.append_child SelectOne.new(width: 0.999, height: 0.999, options: [
      'hello', 'world'
    ])
    screen.render
  }
  screen.start
end

test
