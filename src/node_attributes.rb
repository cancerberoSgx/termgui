# Manages Node's attributes
class Attributes
  def initialize(attrs = {})
    @attrs = attrs
  end

  def names
    @attrs.keys
  end

  def pairs
    @attrs.keys.map { |n| { name: n, value: @attrs[n] } }
  end

  def set_attribute(name, value)
    @attrs[name.to_sym] = value
    self
  end

  def get_attribute(name)
    @attrs[name.to_sym]
  end

  def to_s
    @attrs.to_s
  end
end
