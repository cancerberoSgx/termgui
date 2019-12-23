require_relative '../util'

# Adds hash compatibility using instance_variable
module HashObject
  # assign properties to this on given hash or Style object
  def assign(style)
    object_assign(self, new_from_hash(style))
  end

  # creates a new empty instance and assign values in given hash or instance.
  # This could be class method, but we want to be available to user classes
  def new_from_hash(hash)
    hash_obj = hash
    if hash.instance_of? Hash
      hash_obj = self.class.new
      merge_hash_into_object(hash, hash_obj)
    end
    instance = self.class.new
    object_assign(instance, hash_obj)
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
