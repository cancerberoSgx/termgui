require_relative '../src/input'

i=Input.new
i.subscribe('key', Proc.new {|e| 
  puts e[:key]
  if e[:key]=='q'
    exit
  end
})
i.start