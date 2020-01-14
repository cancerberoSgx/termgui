require_relative '../src/log'

class Logger
  include Log
  def initialize(file = 'log.txt')
    @file = file
  end
end

l = Logger.new 'tmp_log1.txt'
l.log(a: [1, 2, { b: false, c: 'hello' }])
