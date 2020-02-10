require 'test/unit'
include Test::Unit::Assertions
require_relative '../../src/screen'
require_relative '../../src/widget/button'
require_relative '../../src/widget/inline'

class InlineTest < Test::Unit::TestCase
  def test_simple
    s = Screen.new_for_testing(width: 30, height: 10)
    i = s.append_child Inline.new(height: 5, width: 0.99, ch: '.')
    s.render
    assert_equal '............................. \n' \
                 '............................. \n' \
                 '............................. \n' \
                 '............................. \n' \
                 '............................. \n' \
                 '                              \n' \
                 '                              \n' \
                 '                              \n' \
                 '                              \n' \
                 '                              \n', s.print

    i.append_child Button.new(text: 'hello')
    i.append_child Button.new(text: 'how are yout')
    i.append_child Button.new(text: 'long?')
    i.append_child Button.new(text: 'day out')
    i.append_child Button.new(text: 'there?')
    s.render
    assert_equal '┌─────┐┌────────────┐........ \n' \
                 '│hello││how are yout│........ \n' \
                 '└─────┘└────────────┘........ \n' \
                 '┌─────┐┌───────┐┌──────┐..... \n' \
                 '│long?││day out││there?│..... \n' \
                 '└─────┘└───────┘└──────┘..... \n' \
                 '............................. \n' \
                 '                              \n' \
                 '                              \n' \
                 '                              \n', s.print
  end
end
