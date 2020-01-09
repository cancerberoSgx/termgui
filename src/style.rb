require_relative 'color'
require_relative 'util'
require_relative 'util/hash_object'

# refers to properties directly implemented using ansi escape codes
# responsible of printing escape ansi codes for style
# Styles are data objects, supporting hash to instantiate, assign, equals, print
class BaseStyle
  include HashObject

  attr_accessor :fg, :bg

  def initialize(fg: nil, bg: nil)
    @fg = fg
    @bg = bg
  end

  # Prints the style as escape sequences.
  # This method shouln't be overriden by subclasses since it only makes sense for basic properties defined here.
  def print
    color @fg, @bg
  end

  def reset
    @bg = @fg = @wrap = @border = nil
  end

  # if a hash is given returns a new Style instance with given properties. If an Style instance if given, returns it.
  def self.from_hash(obj)
    if obj == nil
      nil
    elsif obj.instance_of? Hash
      merge_hash_into_object obj, new
    else
      obj
    end
  end
end

# style for the border
class Border < BaseStyle
  attr_reader :style

  def initialize(fg: nil, bg: nil, style: nil)
    super(fg: fg, bg: bg)
    @style = style.nil? ? nil : style.to_s
  end

  def style=(style)
    @style = style&.to_s
  end
end

# Element style (`element.style` type)
class Style < BaseStyle
  attr_accessor :border, :wrap, :padding, :focus

  def initialize(fg: nil, bg: nil, border: nil, wrap: false, padding: nil, focus: nil)
    super(fg: fg, bg: bg)
    @wrap = wrap
    # TODO: move this border checking & init to hash_object
    if border.nil?
      @border = nil
    elsif border.instance_of? Border
      @border = border
    elsif border.instance_of? Hash
      @border = Border.new
      @border.assign(border)
    end
    @padding = padding
    @focus = focus || self.clone
  end
end

# # Parses a string CSS-like "bg: red; fg: white; border-style: classic"
# # Notice that `border-style` is assigned to @border.style and treated specially
# def parse_style(s)
#   statements = s.split(';')
#   statements.each do |statement|
#     a = statement.split(':')
#     throw "Syntax error in statement: #{statement}" if a.length != 2
#     property = a[0]
#     value = a[1]
#     parse_style_set_property(s, property, value)
#   end
# end

# def parse_style_set_property(_s, property, value)
#   if property.starts_with? 'border-'
#     throw "TODO, not implemented : property.starts_with? 'border-'"
#   else
#     o = {}
#     o[property] = value
#     throw 'TODO, not implemented '
#   end
# end
