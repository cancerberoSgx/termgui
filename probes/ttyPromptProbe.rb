require "tty-prompt"

prompt = TTY::Prompt.new

prompt.ask('What is your name?', default: ENV['USER'])

prompt.multiline("Description?")