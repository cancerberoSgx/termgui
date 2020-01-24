require_relative 'util'
require_relative 'util/hash_object'
require_relative 'tco/tco_termgui'

module TermGui
  # refers to properties directly implemented using ansi escape codes
  # responsible of printing escape ansi codes for style
  # Styles are data objects, supporting hash to instantiate, assign, equals, print
  class BaseStyle
    include HashObject

    attr_accessor :fg, :bg, :underline, :bold, :blink, :inverse, :fraktur, :framed

    # TODO: for some reason **args is not working here that's why we have all subclasses props
    def initialize(fg: nil, bg: nil, bold: nil, blink: nil, inverse: nil, underline: nil, framed: nil, fraktur: nil, bright: nil, wrap: nil, border: nil, padding: nil, style: nil)
      @fg = fg
      @bg = bg
      @bold = bold || bright
      @blink = blink
      @inverse = inverse
      @underline = underline
      @fraktur = fraktur
      @framed = framed
    end

    # Prints the style as escape sequences.
    # This method shouln't be overriden by subclasses since it only makes sense for basic properties defined here.
    def print(s = nil)
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
        return nil
      elsif obj.instance_of? Hash
        r = merge_hash_into_object obj, new
      else
        r = obj
      end

      r.focus = r.focus || r.clone
      # r.border = r.border || r.clone
      r.action = r.action || r.clone
      r.enter = r.enter || r.clone
      r
    end

    def pretty_print(delete_nil = true, delete_empty = true)
      h = to_hash
      h.keys.each do |k|
        h.delete k if delete_nil && h[k] == nil
        # p [k, delete_nil&&h[k]==nil, h[k].respond_to?( :to_hash) , h[k].is_a?(Hash), h[k].class, (h[k].respond_to?( :to_hash)|| h[k].is_a?(Hash) ) && object_variables_to_hash(h[k]).keys.select{|k|h[k]!=nil} ]
        if delete_empty && (h[k].respond_to?(:to_hash) || h[k].is_a?(Hash)) && object_variables_to_hash(h[k]).keys.reject { |k| h[k] == nil }.empty?
          h.delete k
        end
      end
      #  p h.keys
      #  "{#{h.keys.map { |k| "#{k}: #{pretty_print_value(h[k])}" }.join(', ')}}"  .split( /, [^\s]+: \{\}/).join('')
      "{#{h.keys.map { |k| "#{k}: #{pretty_print_value(h[k])}" }.join(', ')}}" .split(/, [^\s]+: \{\}/).join('')
    end

    def pretty_print_value(v)
      v.respond_to?(:pretty_print) ? v.pretty_print : v.to_s
    end
    # h.keys.length ? "{#{h.keys.map { |k| "#{k}: #{h[k].respond_to?(:pretty_print) ? h[k].pretty_print : h[k].to_s}" }.join(', ')} }" : ''
    # end

    def self.from_json(s)
      r = from_hash(json_parse(s))
      r.border = from_hash(r.border || new)
      r.focus = from_hash(r.focus || new)
      r.enter = from_hash(r.enter || new)
      r.action = from_hash(r.action || new)
      r
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

    def initialize(**args)
      super
      @style = args[:style]&.to_s || 'single'
    end

    def style=(style)
      @style = style&.to_s
    end
  end

  # Element style (`element.style` type)
  class Style < BaseStyle
    attr_accessor :border, :wrap, :padding, :focus, :enter, :action

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
      padding = args[:padding]
      focus = args[:focus] || clone
      enter = args[:enter] || clone
      action = args[:action] || clone

      @padding = padding
      @focus = focus
      @enter = enter
      @action = action
    end
  end
end

BaseStyle = TermGui::BaseStyle
Border = TermGui::Border
Style = TermGui::Style
