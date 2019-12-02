require_relative '../src/input'

i=Input.new
i.defaultExitKeys
i.subscribe('key', Proc.new {|e| $stdout.write  "'#{e.key}': 'C-', "})
i.start

