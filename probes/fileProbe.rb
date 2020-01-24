require 'FileUtils'
require_relative '../src/widget/button'
require_relative '../src/screen'
require_relative '../src/log'
require_relative '../src/element'
require_relative '../src/xml/xml'

class Entry < Button
  def default_style
    s = super
    s.border = nil
    s.focus.border = nil
    s.action.border = nil
    s.enter.border = nil
    s
  end
end

s = Screen.new

s.event.add_key_listener('down') do
  s.query_by_name('container')[0].offset.top += 5
  s.query_by_name('container')[0].render
end
s.event.add_key_listener('up') do
  s.query_by_name('container')[0].offset.top -= 5
  s.query_by_name('container')[0].render
end

entry_action = proc { |e|
  s.query_by_name('content')[0].text = File.open(e.target.text, 'r').read
  s.query_by_name('container')[0].offset.top = 0
  s.query_by_name('container')[0].render
}

files = Dir.glob('**/*test.rb')
template = File.open('probes/fileProbeTemplate.erb', 'r').read
render_erb(template: template, parent: s, binding: binding, custom_builders: { entry: Entry })

s.start
