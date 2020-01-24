require_relative '../util'

# Adds hash compatibility using instance_variable
module HashObject
  # Assigns this instance's properties from given Hash or HashObject instance.
  def assign(hash)
    object_assign(self, hash)
  end

  # alias merge assign

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

def object_variables_to_hash(obj)
  return obj if obj.is_a?(Hash)

  hash = {}
  obj.instance_variables.each do |name|
    s = name.to_s
    key = s.slice(1, s.length).to_sym
    hash[key] = obj.instance_variable_get(name)
  end
  hash
end

def merge_hash_into_object(hash, obj)
  hash.keys.each do |key|
    name = variable_name key
    if obj.instance_variable_defined? name
      value = hash[key]
      obj.instance_variable_set(name, value) unless value == nil
    end
  end
  obj
end

# assign properties from `src` to `dest`. by default it ignores nil properties.
# TODO: option to recurse on object descendants
def object_assign(dest, src, ignore_nil = true)
  unless src.nil?
    dest.instance_variables.each do |name|
      val = nil
      if src.instance_of? Hash
        key = variable_key(name)
        val = src[key]
      else
        val = src.instance_variable_get(name)
      end
      dest.instance_variable_set name, val unless ignore_nil && val == nil
    end
  end
  dest
end

# returns true if given objects have same keys and values (using != for comparisson)
def object_equal(obj1, obj2)
  vars1 = obj1.instance_variables
  vars2 = obj2.instance_variables
  return false unless vars1.length == vars2.length
  # if they don't have exactly the same instance_variables names then return false
  return false unless vars1.map(&:to_s).sort.to_s == vars2.map(&:to_s).sort.to_s

  equal = true
  some(vars1, proc { |v|
    val1 = obj1.instance_variable_get(v)
    val2 = obj2.instance_variable_get(v)
    if val1 != val2
      equal = false
      true
    else
      false
    end
  })
  equal
end

# uses obj.instance_variable_get but supports the variable name in these formats "foo", :foo, :@foo and "@foo"
def get_instance_variable(obj, name)
  obj.instance_variable_get(variable_name(name))
end

# uses obj.instance_variable_set but supports the variable name in these formats "foo", :foo, :@foo and "@foo"
def set_instance_variable(obj, name)
  obj.instance_variable_set(variable_name(name))
end

# given a name in any of these formats "foo", :foo, :@foo and "@foo" it returns a valid instance_variable name (symbol), i.e. :@foo
def variable_name(name)
  s = name.to_s
  s = "@#{s}" unless s.start_with? '@'
  s.to_sym
end

# does the opossite as variable_name : given a variable name like "a", "@a", :@a, :a  it will return a valid symbol hash key, like :a
def variable_key(name)
  s = name.to_s
  s = s.slice(1) if s.start_with? '@'
  s.to_sym
end
