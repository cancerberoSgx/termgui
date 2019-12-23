require_relative '../util'

# Adds hash compatibility using instance_variable
module HashObject
  # Assigns this instance's properties from given Hash or HashObject instance.
  def assign(hash)
    object_assign(self, hash)
  end

  # creates a new empty instance and assign values in given hash or instance.
  # This could be class method, but we want to be available to user classes.
  # Warning: since `new` is called variables will be initialized even though not present in given hash.
  def new_from_hash(hash)
    if hash == nil
      self.class.new.assign(self)
    else
      hash_obj = hash
      if hash.instance_of? Hash
        hash_obj = self.class.new
        merge_hash_into_object(hash, hash_obj)
      end
      instance = self.class.new
      object_assign(instance, hash_obj)
    end
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
