require "json"

def JSONParse(str)
  JSON.parse(str)
end

def JSONStringify(obj)
  JSON.generate(obj)
end

# TODO: hack because \n chars are not printed with puts or print:
def print_string(s)
  s.split('\n').map { |s| puts s || "" }
end

def parse_integer(s, default = nil)
  begin
    Integer(s)
  rescue
    default
  end
end

def unquote(s)
  s[1..s.length - 1]
end

def nextTick
  sleep 0.0000001
end

CHARS = ("a".."z").to_a.concat(("A".."Z").to_a).push("_", "-", "@", "!", "#", "$", "%", "^", "&", "*", "=", "+")

def randomChar
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
    i = i + 1
  end
  value
end
