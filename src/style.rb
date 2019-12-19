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
    @style = style.nil? ? nil : style.to_s
  end
end

# Element style (`element.style` type)
class Style < BaseStyle
  attr_reader :border

  def initialize(fg: nil, bg: nil, border: nil)
    super(fg: fg, bg: bg)
    if border.nil?
      @border = nil
    elsif border.instance_of?(Border)
      @border = border
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
  statements = s.split(';')
  # style = Style.new
  statements.each do |statement|
    a = statement.split(':')
    throw "Syntax error in statement: #{statement}" if a.length != 2
    property = a[0]
    value = a[1]
    parse_style_set_property(s, property, value)
  end
end

def parse_style_set_property(_s, property, value)
  if property.starts_with? 'border-'
    throw "TODO, not implemented : property.starts_with? 'border-'"
  else
    o = {}
    o[property] = value
    # s.
    throw 'TODO, not implemented '
  end
end
