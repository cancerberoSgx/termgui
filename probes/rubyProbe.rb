
p 'hello'.start_with? 'hello'

class A
  attr_accessor  :b, :a
  # @var1 = 1
  def initialize
    @b = 1
    @a = 1
  end
end
aa22 = A.new
aa33 = aa22.class.new
p aa33
# p A.singleton_class.instance_methods.map{|s|s.to_s} .sort
dd=A.new
p (dd.instance_variables.map{|v|v.to_s}).sort
def object_variables_to_hash(obj)
  hash = {}
  obj.instance_variables.each do |name|
    hash[name] = obj.instance_variable_get(name)
  end
  hash
end
def merge_hash_into_object(hash, obj)
  hash.keys do |key|
    if obj.instance_variable_defined?
      name = "@#{key}".to_sym
      obj.instance_variable_set(name, obj.instance_variable_get(name))
    end
  end
  obj
end
a = A.new
a.a = 2
obj = merge_hash_into_object({b: 1}, a)
p obj
# p A.new.instance_variables
# p A.instance_variables
# a = A.new
# p a.methods
# p a.singleton_methods
# p a.properties

# def gg(*args)
#   # p args
#   # yield block
#   block=args[args.length-1]
#   block.call args.sample
# end

# gg 1,2,3, proc {|i| p 'y', i}

# def hh(a, &block)
#   b=yield
#   p a, b
# end
# hh(555) {p 'hhh'; 222}

# class D
#   def initialize(*args)
#     p args
#   end
# end
# D.new(a: 1, b: false)

# x = 3.4
# p x.truncate

# # def ff(a, &block)
# #   block.call a
# # end
# # ff [1,2,3] Proc.new({|e| p 'hello'})

# a = {}.instance_of? Hash
# p a.to_s
# a = [].instance_of? Hash
# p a.to_s

# class A
#   attr_reader :name, :children

#   def initialize(name: 'node', children: [])
#     @name = name
#     @children = children
#   end

#   def to_s
#     "Node(name: #{name}, children: [#{children.map(&:to_s).join(', ')}])"
#   end
# end

# a = A.new(name: 'seba', children: [
#             A.new(name: 'lk', children: [
#                     A.new,
#                     A.new(name: 'lau', children: [A.new(name: 'rufo')]),
#                     A.new
#                   ])
#           ])
# print a

# # a=1
# # b='uno'
# # c={a: a, b: b}
# # # c={a, b}   does work
# # print c

# # a = Time.now
# # b = a - 1
# # p a, b
