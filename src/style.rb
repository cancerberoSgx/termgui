require_relative 'util'
require_relative 'util/hash_object'
require_relative 'tco/tco_termgui'

module TermGui
  # refers to properties directly implemented using ansi escape codes
  # responsible of printing escape ansi codes for style
  # Styles are data objects, supporting hash to instantiate, assign, equals, print
  class BaseStyle
    include HashObject

    attr_accessor :fg, :bg, :underline, :bold, :blink

    def initialize(fg: nil, bg: nil, bold: nil, blink: nil, underline: nil, bright: nil, wrap: nil, border: nil)
      @fg = fg
      @bg = bg
      @bold = bold
      @blink = blink
    end

    # Prints the style as escape sequences.
    # This method shouln't be overriden by subclasses since it only makes sense for basic properties defined here.
    def print(s = nil)
      # "#{color @fg, @bg}#{attributes bold: @bold, blink: @blink}"
      if s == nil
        TermGui.open_style(self)
      else
        TermGui.print(s, self)
      end
    end

    def reset
      @bg = @fg = @wrap = @border = nil
    end

    # returns true if self has the same properties of given hash or Style and each property value is equals (comparission using ==)
    def equals(style)
      object_equal(self, BaseStyle.from_hash(style))
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

    def bright
      @bold
    end

    def bright=(value)
      @bold = value
    end
  end

  # style for the border
  class Border < BaseStyle
    attr_reader :style

    def initialize(fg: nil, bg: nil, style: 'single')
      super(fg: fg, bg: bg)
      @style = style.to_s
    end

    def style=(style)
      @style = style&.to_s
    end
  end

  # Element style (`element.style` type)
  class Style < BaseStyle
    attr_accessor :border, :wrap, :padding, :focus

    def initialize(**args)
      super
      @wrap = args[:wrap]
      # TODO: move this border checking & init to hash_object
      if args[:border].nil?
        @border = nil
      elsif args[:border].instance_of? Border
        @border = args[:border]
      elsif args[:border].instance_of? Hash
        @border = Border.new
        @border.assign(args[:border])
      end
      @padding = args[:padding]
      @focus = args[:focus] || clone
    end
  end
end

BaseStyle = TermGui::BaseStyle
Border = TermGui::Border
Style = TermGui::Style
