require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/key'

class KeyTest < Test::Unit::TestCase
  def test_char_to_name
    assert_equal 'C-z', char_to_name('\x1A')
  end

  def test_name_to_char
    assert_equal '\x1A', name_to_char('C-z')
    assert_equal 'q', name_to_char('q')
  end
end
