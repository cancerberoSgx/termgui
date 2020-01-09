class A
  def initialize(a: 1, **args)
    @a = 1
  end
end

class B < A
  def initialize(**args)
    # p args.instance_methods
    super
    @b = args[:b]
  end
end
class C < B
  def initialize(*args)
    super
    @c = args[:c]
  end
end

b = B.new(a: 2, b: 3)
p b