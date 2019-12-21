require_relative 'color'

# refers to properties directly implemented using ansi escape codes
# responsible of printing escape ansi codes for style
class BaseStyle
  # attr_reader :fg, :bg
  attr_accessor :fg, :bg

  def initialize(fg: nil, bg: nil)
    @fg = fg
    @bg = bg
  end

  def assign(style)
    @fg = style.fg || @fg
    @bg = style.bg || @bg
    # TODO: all subclass attrs hardcoded here
    @wrap = style.wrap == false ? false : style.wrap.nil? ? @wrap : style.wrap
    @border = style.border || @border
  end

  def equals(style)
    @bg == style.bg && 
    @fg == style.fg && 
    # TODO: all subclass attrs hardcoded here
      # @border ? @border.equals(style.border) : @border==style.border && 
      @wrap==style.wrap
    end

  # Prints the style as escape sequences.
  # This method shouln't be overriden by subclasses since it only makes sense for basic properties defined here.
  def print
    color @fg, @bg
  end

  def reset
    @bg = @fg = @wrap = @border = nil
  end

  def to_s
    to_hash.to_s
  end

  def to_hash
    {bg: @bg, fg: @fg, 
    # TODO: all subclass attrs hardcoded here
    wrap: @wrap, 
    border: @border
  }
  end

  def self.from_hash(obj)
    if !obj
      nil
    elsif obj.instance_of? Hash
      Style.new(fg: obj[:fg], bg: obj[:bg], wrap: obj[:wrap], border: obj[:border])
      # TODO: all subclass attrs hardcoded here
    else
      obj
    end
  end
end

# style for the border
class Border < BaseStyle
  # box style name (string). See box.rb. Possible values:
  # :single, :double, :round, :bold, :singleDouble, :doubleSingle, :classic
  attr_reader :style

  def initialize(fg: nil, bg: nil, style: nil)
    super(fg: fg, bg: bg)
    @style = style.nil? ? nil : style.to_s
    # @style=style
  end

  def style=(style)
    @style = style&.to_s
  end
end

# Element style (`element.style` type)
class Style < BaseStyle
  attr_accessor :border, :wrap

  def initialize(fg: nil, bg: nil, border: nil, wrap: false)
    super(fg: fg, bg: bg)
    @wrap = wrap
    if border.nil?
      @border = nil
    elsif border.instance_of?(Border)
      @border = border
    else
      # @border = Border.new()
      throw 'seva'
    end
  end

  # def self.from_hash(obj)
  #   s = BaseStyle.from_hash obj
  #   s.border = obj[:border] || nil
  # end

  # def initialize(border = nil)
  # p  (border.instance_of? Border ? border : Border.new(border)).to_s
  # if border==nil
  #   @border = nil
  # elsif border.instance_of?(Border)
  #   @border =  border
  # else
  #   @border = Border.new()
  # end
  # @border =  ? nil : border.instance_of?(BaseStyle) ? border : Border.new
  # end
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
