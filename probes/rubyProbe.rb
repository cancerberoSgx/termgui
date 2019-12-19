def gg(*args)
  # p args
  # yield block
  block=args[args.length-1]
  block.call args.sample
end

gg 1,2,3, proc {|i| p 'y', i}

def hh(a, &block)
  b=yield
  p a, b
end
hh(555) {p 'hhh'; 222}


class D 
  def initialize(*args)
    p args
  end
end
D.new(a: 1, b: false)



x = 3.4
p x.truncate

# def ff(a, &block)
#   block.call a
# end
# ff [1,2,3] Proc.new({|e| p 'hello'})

a = {}.instance_of? Hash
p a.to_s
a = [].instance_of? Hash
p a.to_s


class A
  attr_reader :name, :children

  def initialize(name: 'node', children: [])
    @name = name
    @children = children
  end

  def to_s
    "Node(name: #{name}, children: [#{children.map(&:to_s).join(', ')}])"
  end
end

a = A.new(name: 'seba', children: [
            A.new(name: 'lk', children: [
                    A.new,
                    A.new(name: 'lau', children: [A.new(name: 'rufo')]),
                    A.new
                  ])
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
