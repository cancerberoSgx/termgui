require_relative "../src/input"

i = Input.new
i.subscribe("key", Proc.new { |e|
  $stdout.write "#{e.key}"
  if e.key == "q"
    exit
  end
})
i.start
