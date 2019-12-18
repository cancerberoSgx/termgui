# frozen_string_literal: true

require_relative '../src/screen'
require_relative '../src/util'
require_relative '../src/style'
require_relative '../src/color'
require 'io/console'
require 'io/wait'

N = 2
s = Screen.new
s.event.addKeyListener('q', proc { |_e| s.destroy })
s.clear
s.style = { fg: 'red' }
s.rect x: 2, y: 3, width: 6, height: 5
s.start
