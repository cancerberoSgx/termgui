# Manages Node's attributes
class Attributes
  def initialize(attrs = {})
    @attrs = attrs
  end

  def names
    @attrs.keys
  end

  def set_attribute(name, value)
    @attrs[name] = value
    self
  end

  def get_attribute(name)
    @attrs[name]
  end

  def to_s
    @attrs.to_s
  end
end
