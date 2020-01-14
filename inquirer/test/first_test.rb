require_relative '../src/inquirer'

inquirer = AbstractInquirer.new(on_answer: proc {|answer| p "And the answer is '#{answer}'"})
inquirer.start
# inquire({
#   type: 'select',
#   text: 'Please choose your favorite color',
#   options: [
#     {value: 'green', label: 'Green'},
#     {value: 'red', label: 'Red'}
#   ]
# }) {|color|
#   p "Color answer is: #{color}"
# }
