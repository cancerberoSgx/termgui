require_relative '../src/screen'
require_relative '../src/style'
require_relative '../src/widget/label'

screen = Screen.new(width: 30, height: 10)
screen.input.install_exit_keys
screen.silent = true
# label = Label.new(text: 'hello world', x: 12, y: 3)
# label.style = { bg: 'white', fg: 'black' }
# label.style.border = Border.new
 
# screen.clear
# label.render screen
# # screen.print.split('\\n').each { |line| puts "'#{line}\\n' + " }
# expected = '                              \n' \
#            '                              \n' \
#            '           ┌───────────┐      \n' \
#            '           │hello world│      \n' \
#            '           └───────────┘      \n' \
#            '                              \n' \
#            '                              \n' \
#            '                              \n' \
#            '                              \n' \
#            '                              \n'
# if expected != screen.print
#   p 'FAIL'
# end

label2 = Label.new(
  text: 'hello world a more longer text this time a asd ', x: 3, y: 5, width: 10, 
  style: Style.new(bg: 'white', fg: 'blue', wrap: true, border: Border.new)
  )
label2.style = { bg: 'white', fg: 'blue', wrap: true}
label2.style.wrap=true
# label2.style.border = Border.new
# label2.style.wrap = true
screen.clear

# screen.append_child(label)
screen.append_child(label2)
screen.render

screen.print.split('\\n').each { |line| puts "'#{line}\\n' + " }


# screen.start
