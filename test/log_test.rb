require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/log'

class Logger1
  include Log
  def initialize(file = 'log.txt')
    @file = file
  end
end

class LogTest < Test::Unit::TestCase
  def test_log
    `rm tmp_test_log.txt`
    l = Logger1.new 'tmp_test_log.txt'
    l.log(a: [1, 2, { b: false, c: 'hello' }])
    s = File.open('tmp_test_log.txt', 'r').read
    assert_equal "------\n" + "{:a=>[1, 2, {:b=>false, :c=>\"hello\"}]}\n", s
    `rm tmp_test_log.txt`
  end
end
