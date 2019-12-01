require_relative '../src/input'

i=Input.new
i.subscribe('key', lambda {|e| puts e})
i.start