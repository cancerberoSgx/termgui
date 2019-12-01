require 'json'

def JSONParse(str)
  JSON.parse(str)
end

def JSONStringify(obj)
  JSON.generate(obj)
end

# TODO: hack because \n chars are not printed with puts or print:
def print_string(s)
  s.split('\n').map {|s| puts s || ''}
end

def parse_integer(s, default=nil)
  begin
    Integer(s)
  rescue
    default
  end
end

def unquote(s)
  s[1..s.length-1]
end

def nextTick
  sleep 0.0000001
end
# def setTimeout(ms, proc)
#   sleep ms
# end