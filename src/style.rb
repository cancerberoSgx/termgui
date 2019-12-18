require_relative "color"

# refers to properties directly implemented using ansi escape codes
# responsible of printing escape ansi codes for style
class BaseStyle
  attr :fg, :bg
  attr_accessor :fg, :bg

  def initialize(fg: nil, bg: nil)
    @fg = fg
    @bg = bg
  end

  def assign(style)
    @fg = style.fg || @fg
    @bg = style.bg || @bg
  end

  def equals(style)
    @bg == style.bg && @fg == style.fg
  end

  # Prints the style as escape sequences. 
  # This method shouln't be overriden by subclasses since it only makes sense for basic properties defined here.
  def print
    color @fg, @bg
  end

  def reset
    @bg = @fg = nil
  end

  def self.from_hash(obj)
    if !obj
      nil
    elsif obj.instance_of? Hash
      Style.new(fg: obj[:fg], bg: obj[:bg])
    else
      obj
    end
  end
end

class Border < BaseStyle

  attr :style

  def initialize(fg: nil, bg: nil, style: nil)
    super(fg: fg, bg: bg)
    @style=style==nil ? nil : style.to_s
    # @style=style
  end
  
  # box style name (string). See box.rb. Possible values: 
  # :single, :double, :round, :bold, :singleDouble, :doubleSingle, :classic
  def style
    @style
  end

  def style=(style)
    @style=style==nil ? nil : style.to_s
  end
end

class Style < BaseStyle
  attr :border

  def initialize(fg: nil, bg: nil, border: nil)
    super(fg: fg, bg: bg)
    if border==nil
      @border = nil
    elsif border.instance_of?(Border)
      @border =  border
    else
      # @border = Border.new()
      throw 'seva'
    end
  end

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

# Parses a string CSS-like "bg: red; fg: white; border-style: classic"
# Notice that `border-style` is assigned to @border.style and treated specially
def parse_style(s)
  statements=s.split(';')
  style = Style.new
  statements.each{|statement|
    a=statement.split(':')
    if a.length != 2
      throw "Syntax error in statement: #{statement}"
    end
    property = a[0]
    value = a[1]
    parse_style_set_property(s, property, value)
  }
end

def parse_style_set_property(s, property, value)
  if property.starts_with? 'border-'
    throw "TODO, not implemented : property.starts_with? 'border-'"
  else
    o={}
    o[property] = value
    # s.
    throw "TODO, not implemented "
  end
end

