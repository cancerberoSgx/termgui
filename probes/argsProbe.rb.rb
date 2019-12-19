
def f(a: 1, b: 2, c: 3, d: 4)
  print a + b + c + d
end

# f()

f a: 1

a = { a: 1 }
b = { b: 2 }
print a.merge b
print b.merge ({ c: 3 })
