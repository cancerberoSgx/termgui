
require_relative '../src/input'

i = Input.new
i.install_exit_keys
i.subscribe('key', proc { |e| $stdout.write "'#{e.key}': 'C-', -- #{e}" })
i.start
