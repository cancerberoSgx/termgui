
module TermGui
  # represents a scroll viewport offset
class Offset
  attr_accessor :left, :top

  def initialize(left: 0, top: 0)
    @left = left
    @top = top
  end
end

# Represents a rectangle in the form of {top, left, bottom, top}
class Bounds < Offset
  attr_accessor :right, :bottom

  def initialize(left: 0, right: 0, top: 0, bottom: 0)
    super(left: left, top: top)
    @right = right
    @bottom = bottom
  end

  def self.from_hash(hash)
    merge_hash_into_object hash, Bounds.new
  end
end
end
Offset = TermGui::Offset
Bounds = TermGui::Bounds
