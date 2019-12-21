require_relative 'color'
require_relative 'util'

module HashObject

  # assign properties to this on given hash or Style object
  def assign(style)
    object_assign(self, BaseStyle.from_hash(style))
  end

  # returns true if self has the same properties of given hash or Style and each property value is equals (comparission using ==)
  def equals(style)
    object_equal(self, BaseStyle.from_hash(style))
  end

  def get(name)
    get_instance_variable self, name
  end

  def to_s
    to_hash.to_s
  end

  def to_hash
    object_variables_to_hash self
  end

end
