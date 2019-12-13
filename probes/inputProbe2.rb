require_relative '../src/input'

i=Input.new
i.install_exit_keys
i.subscribe('key', Proc.new {|e| $stdout.write  "'#{e.key}': 'C-', "})
i.start

