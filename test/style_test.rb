# require 'test/unit'
# include Test::Unit::Assertions
# require_relative '../src/style'

# class StyleTest < Test::Unit::TestCase
#   def test_from_json
#     str = '{"bg": "red", "border": {"fg": "blue"}}'
#     s = Style.from_json(str)
#     assert_equal 'red', s.bg
#     assert_equal 'blue', s.border.fg
#   end

#   def test_pretty_print
#     assert_true Style.new(bg: 'blue').pretty_print.include? 'bg: blue'
# # assert_equal '{bg: black}', Style.new(bg: 'blue').pretty_print
#     # p '{bg: black, focus: {}, enter: {}, action: {}}'.split(/, [^\s]+: \{\}/)
#   end
# end
