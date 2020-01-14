require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/util/css'

class CssTest < Test::Unit::TestCase
  def test_parse_rules
    p = CSSParser.new
    expected = '[{:selector=>"foo", :body=>"bg: red; padding-top: 3"}, {:selector=>".bar .primary", :body=>"border: double black"}, {:selector=>"; .sidebar .container", :body=>"padding: 1"}]'
    actual = p.parse_rules('foo {bg: red; padding-top: 3} .bar .primary {border: double black}; .sidebar .container { padding: 1}').to_s
    assert_equal expected, actual
  end
  def test_parse
    p = CSSParser.new
    expected = "[{:selector=>\"foo\", :properties=>[{:name=>\"bg\", :value=>\"red\"}, {:name=>\"padding-top\", :value=>\"3\"}]}, {:selector=>\".bar .primary\", :properties=>[{:name=>\"border\", :value=>\"double black\"}]}, {:selector=>\"; .sidebar .container\", :properties=>[{:name=>\"padding\", :value=>\"1\"}]}]"
    actual = p.parse('foo {bg: red; padding-top: 3} .bar .primary {border: double black}; .sidebar .container { padding: 1}').to_s
    assert_equal expected, actual
  end
end
