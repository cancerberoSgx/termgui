require 'json'

# def json_parse(str)
#   JSON.parse(str)
# end

# def json_stringify(obj)
#   JSON.generate(obj)
# end

# TODO: hack because \n chars are not printed with puts or print:
def print_string(str)
  str.split('\n').map { |s| puts s || '' }
end

def parse_integer(s, default = nil)
  Integer(s)
rescue StandardError
  default
end

# returns true if given value is between 0.0 and 1.0
def is_percent(val)
  val && val > 0 && val < 1
end

def unquote(s)
  s[1..s.length - 1]
end

def next_tick
  sleep 0.0000001
end

CHARS = ('a'..'z').to_a.concat(('A'..'Z').to_a).push('_', '-', '@', '!', '#', '$', '%', '^', '&', '*', '=', '+')

def random_char
  CHARS.sample
end

# similar to JS Array.prototype.some
def some(array, predicate)
  i = 0
  value = nil
  while i < array.length
    e = array[i]
    value = predicate.call e
    if value
      value = array[i]
      break
    else
      value = nil
    end
    i += 1
  end
  value
end

def object_variables_to_hash(obj)
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
    name = "@#{key}".to_sym
    if obj.instance_variable_defined? name
      value = hash[key]
      obj.instance_variable_set(name, value)
    end
  end
  obj
end

def object_assign(dest, src)
  src.instance_variables.each do |name|
    val = src.instance_variable_get(name)
    dest.instance_variable_set name, val unless val.nil?
  end
end

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
  obj.instance_variable_get(variable_name name)
end

# uses obj.instance_variable_set but supports the variable name in these formats "foo", :foo, :@foo and "@foo"
def set_instance_variable(obj, name)
  obj.instance_variable_set(variable_name name)
end

# given a name in any of these formats "foo", :foo, :@foo and "@foo" it returns a valid instance_variable name (symbol), i.e. :@foo
def variable_name(name)
  s = name.to_s
  # p s
  s = "@#{s}" unless s.start_with? '@'
  s.to_sym
end