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
  val&.positive? && val < 1
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
