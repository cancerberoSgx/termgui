def unquote(s)
  s[1..s.length-1]
end
def nextTick
  sleep 0.00001
end
# def setTimeout(ms, proc)
#   sleep ms
# end