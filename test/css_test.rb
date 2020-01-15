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

  def test_parse_rules_properties
    p = CSSParser.new
    expected = '[{:selector=>"foo", :properties=>[{:name=>"bg", :value=>"red"}, {:name=>"padding-top", :value=>"3"}]}, {:selector=>".bar .primary", :properties=>[{:name=>"border", :value=>"double black"}]}, {:selector=>"; .sidebar .container", :properties=>[{:name=>"padding", :value=>"1"}]}]'
    actual = p.parse_rules_properties(p.parse_rules('foo {bg: red; padding-top: 3} .bar .primary {border: double black}; .sidebar .container { padding: 1}')).to_s
    assert_equal expected, actual
  end

  def test_parse_rules_selectors
    p = CSSParser.new
    expected = '[{:selectors=>[[{:name=>"foo", :operator=>nil}]], :properies=>[{:name=>"bg", :value=>"red"}, {:name=>"padding-top", :value=>"3"}]}, {:selectors=>[[{:name=>".bar", :operator=>" "}, {:name=>".primary", :operator=>nil}]], :properies=>[{:name=>"border", :value=>"double black"}]}, {:selectors=>[[{:name=>";", :operator=>" "}, {:name=>".sidebar", :operator=>" "}, {:name=>".container", :operator=>nil}]], :properies=>[{:name=>"padding", :value=>"1"}]}]'
    rules = p.parse_rules_properties(p.parse_rules('foo {bg: red; padding-top: 3} .bar .primary {border: double black}; .sidebar .container { padding: 1}'))
    actual = p.parse_rules_selectors(rules).to_s
    assert_equal expected, actual
  end

  def test_parse
    p = CSSParser.new
    expected = '[{:selectors=>[[{:name=>"foo", :operator=>nil}]], :properies=>[{:name=>"bg", :value=>"red"}, {:name=>"padding-top", :value=>"3"}]}, {:selectors=>[[{:name=>".bar", :operator=>" "}, {:name=>".primary", :operator=>nil}]], :properies=>[{:name=>"border", :value=>"double black"}]}, {:selectors=>[[{:name=>";", :operator=>" "}, {:name=>".sidebar", :operator=>" "}, {:name=>".container", :operator=>nil}]], :properies=>[{:name=>"padding", :value=>"1"}]}]'
    actual = p.parse('foo {bg: red; padding-top: 3} .bar .primary {border: double black}; .sidebar .container { padding: 1}').to_s
    assert_equal expected, actual
  end

  def test_parse_selector
    expected = '[{:name=>"a", :operator=>">"}, {:name=>"b", :operator=>" "}, {:name=>"c", :operator=>">"}, {:name=>"d", :operator=>" "}, {:name=>"f", :operator=>nil}]'
    assert_equal expected, CSSParser.new.parse_selector('a>  b c>d f').to_s
  end
end
