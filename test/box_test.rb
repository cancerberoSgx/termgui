# frozen_string_literal: true

require 'test/unit'
include Test::Unit::Assertions
require_relative '../src/box'

class BoxTest < Test::Unit::TestCase
  def test_simple
    b = draw_box(8, 3)
    assert_equal "box\n#{b.join('\n')}\nbox",
                 "box\n" \
                 '┌──────┐\\n' \
                 '│      │\\n' \
                 "└──────┘\n" \
                 'box'
  end
end
