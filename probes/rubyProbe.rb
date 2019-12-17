a={}.instance_of? Hash
p a.to_s
a=[].instance_of? Hash
p a.to_s



def f1
  p "f1"
  yield
end

def f2(block)
  p "f2"
  block.call
end

def f3
  p "f3"
  yield
end

f1 do
  f2 Proc.new {
    f3 {
      p "end"
    }
  }
end
# implement promise signatures
class Promise
  def initialize(resolve, reject)
    @resolve = resolve
    @reject = reject
  end

  def then
    throw "todo"
  end
end

class A
  attr :name, :children

  def initialize(name: "node", children: [])
    @name = name
    @children = children
  end

  def to_s
    "Node(name: #{name}, children: [#{(children.map { |c| c.to_s }).join(", ")}])"
  end
end

a = A.new(name: "seba", children: [
            A.new(name: "lk", children: [
                    A.new,
                    A.new(name: "lau", children: [A.new(name: "rufo")]),
                    A.new,
                  ]),
          ])
print a

# a=1
# b='uno'
# c={a: a, b: b}
# # c={a, b}   does work
# print c

# a = Time.now
# b = a - 1
# p a, b
