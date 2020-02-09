require 'json'

def json_parse(str)
  JSON.parse(str)
end

def json_stringify(obj)
  JSON.generate(obj)
end

# TODO: why is it so hard in ruby to access an outer local variable from a method ? I needed to create a
# module and a wrapper for somethig very trivial

module Util
  @uc = 0
  def self.unique(s = '')
    @uc += 1
    s + @uc.to_s
  end
end

def to_array(v)
  v.is_a?(Array) ? v : [v]
end

def unique(s = '')
  Util.unique(s)
end

# TODO: hack because \n chars are not printed with puts or print:
def print_string(str)
  str.split('\n').map { |s| puts s || '' }
end

def parse_integer(s, default = nil)
  Integer(s)
rescue StandardError
  default
end

def parse_float(s, default = nil)
  Float(s)
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

def random_int(min = 0, max = 10)
  (min..max).to_a.sample
end

CHARS = ('a'..'z').to_a.concat(('A'..'Z').to_a).push('_', '-', '@', '!', '#', '$', '%', '^', '&', '*', '=', '+')

def random_char
  CHARS.sample
end

def random_color
  [random_int(0, 255), random_int(0, 255), random_int(0, 255)]
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
