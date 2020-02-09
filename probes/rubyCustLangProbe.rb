require_relative '../src/element'
require_relative '../src/screen'
require_relative '../src/widget/button'
require_relative '../src/widget/checkbox'

class Component
  # def self.p1
  #   p self.name
  # end

  @@props = {}
  # @@element_class = {}
  # @children = []

  def self.respond_to_missing?(*args)
    true
  end
# def self.get_prop(p)
#   @@props[self.name.to_sym][p.to_sym]
# end
def self._props
    @@props[self.name.to_sym] = @@props[self.name.to_sym]||{}
  @@props[self.name.to_sym]
end
  def self.create(**args)
    # props(args)
    p = {name: self.name, children: []}.merge(_props).merge(args)
    # c = p[:children]
    # p[:children] = []
    # p[:children] =  p[:children].map{|c|c.create(parent: instance)}
    # print p
    @instance = (_props[:element_class]||Element).method(:new).call p
    # c.each{|c|c.create(p.merge({parent:  @instance}))}
    # @instance.define_singleton_method(:props) { p }
    # c.each{|c|
    # }
    @instance
  end

  # def self.element_class(c)
  #   @@element_class = c
  # end

  def self.props(**args)
    args.keys.each{|k|
      self.method_missing(k, args[k])
    # set_prop(k.to_s, args[k], @@props, '_')
    }
    self
  end
# insta
  # def self.children(*children)
  #   @children = @children||[]
  #   children.each{|c|
  #     @@props[:children].push c.create
  # }
  # end

  def self.method_missing(method, *args, &block)
    value = block || args[0]
    if method.to_s.include?('_')
      set_prop(method.to_s, value, _props, '_')
    else
      _props[method] = value
    end
    self
  end
end

def set_prop(path, value, dest = {}, path_separator = '.')
  path = (path.is_a?(Array) ? path : path.split(path_separator)).map { |p| p.is_a?(Integer) ? p : p.to_sym }
  o = dest
  path.each_with_index do |p, i|
    if path.length - 1 == i
      o[p] = value
    else
      o[p] = o[p].is_a?(Hash) || o[p].is_a?(Array) ? o[p] : p.is_a?(Integer) ? [] : {}
      o = o[p]
    end
  end
  dest
end

# p set_prop('foo.bar.xx', 123, {a: 1, foo: {bar: {g: 9}}})
class MyComponent1 < Component
  width 0.7
  height 0.8
  x 0.2
  y 0.1
  # p1
  text '1' 
end

class MyComponent2 < MyComponent1
  # children [MyComponent3.create]
  style_border_bg 'blue' 
   x 0.5
  action do
    p 'hello'
  end
  text '2' 
  element_class Button
end
class MyComponent3 < MyComponent1
  # style border: { fg: 'green', style: 'double' }
  children [MyComponent1.create, MyComponent2.create]
  # style_border_bg 'red'
  # style_wrap  true
  style_bg 'yellow'
  text '3' 
  # element_class CheckBox
end
# class Root < Component
#   width 0.6
#   height 0.8
#   x 0.1
#   y 0.1
#   children [ MyComponent3.create]
#   style_bg 'green'
# end
s = Screen.new
# p Root.get_prop('children'), Root.get_prop('children').sample.get_prop('children')
# c = MyComponent1.create(parent: s)
s.append_child  MyComponent3.create
s.render
s.start
# p c.props, c.class.name

# p MyComponent2.create

# doc = [
#   [MyComponent2, [
#     MyComponent2, 
#     [[MyComponent2, {text: 'hshsh'}]]
#   ]]
# ]
# doc = {
#   Class: MyComponent2,
# }

# def create(options)
#   if options.is_a?(Array) 
#     _class = options[0]
#     children = options.find{|i|i.is_a?(Array)}||[]
#     props = options.find{|i|i.is_a?(Hash)}||{}
#   else
#     _class = options
#     children= []
#     props = {}
#   end
#   children = children.map
#   _class.create(props.merge)
# end