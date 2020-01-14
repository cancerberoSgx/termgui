require_relative '../src/screen'
require_relative '../src/style'
require_relative '../src/widget/label'

screen = Screen.new(width: 30, height: 10)
screen.input.install_exit_keys
# screen.silent = true
label = Label.new(text: 'hello world', x: 12, y: 3, style: { bg: 'white', fg: 'black' })
# label.style = { bg: 'white', fg: 'black' }
label.style.border = Border.new

screen.clear
label.render screen
# screen.print.split('\\n').each { |line| puts "'#{line}\\n' + " }
expected = '                              \n' \
           '                              \n' \
           '           ┌───────────┐      \n' \
           '           │hello world│      \n' \
           '           └───────────┘      \n' \
           '                              \n' \
           '                              \n' \
           '                              \n' \
           '                              \n' \
           '                              \n'
p 'FAIL' if expected != screen.print

label2 = Label.new(
  text: 'hello longer world', x: 3, y: 5, width: 10,
  style: Style.new(bg: 'yellow', fg: 'blue', wrap: true, border: Border.new)
)
# p 'label2.style', label2.style
# label2.style = { bg: 'white', fg: 'blue'}
# label2.style.wrap=true
# label2.style.border = Border.new(style: :double)
screen.clear

screen.append_child(label2)
screen.render

screen.clear
screen.append_child(label)
screen.append_child(label2)
screen.render

# screen.renderer.print_dev_stdout

# screen.start
