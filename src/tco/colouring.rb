# rubocop:disable Layout/EndAlignment

# adapted from tco
# tco - terminal colouring application and library
# Copyright (c) 2013, 2014 Radek Pazdera

require_relative 'palette'
# require_relative 'style'

module Tco
  class Colouring
    ANSI_FG_BASE = 30
    ANSI_BG_BASE = 40

    attr_reader :palette

    def initialize(configuration)
      @palette = Palette.new configuration.options['palette']
      @output_type = configuration.options['output']
      @disabled = configuration.options['disabled']

      configuration.colour_values.each do |id, value|
        @palette.set_colour_value(parse_colour_id(id), parse_rgb_value(value))
      end

      @names = {}
      configuration.names.each do |name, colour_def|
        @names[name] = resolve_colour_def colour_def
      end

      @styles = {}
      configuration.styles.each do |name, style|
        @styles[name] = Style.new(resolve_colour_def(style[:fg]),
                                  resolve_colour_def(style[:bg]),
                                  style[:bright], style[:underline])
      end
    end

    # Decorate a string according to the style passed. The input string
    # is processed line-by-line (the escape sequences are added to each
    # line). This is due to some problems I've been having with some
    # terminal emulators not handling multi-line coloured sequences well.
    def decorate(string, style)
      # (fg, bg, bright, underline)
      fg = style.fg
      bg = style.bg
      # bright = style.bright
      # underline = style.underline
      return string if !STDOUT.isatty || @output_type == :raw || @disabled

      fg = get_colour_instance fg
      bg = get_colour_instance bg

      output = []
      lines = string.lines.map(&:chomp)
      # p lines
      lines = [''] if lines.length.zero?
      lines.each do |line|
        unless line.length < 0
          line = case @palette.type
                 when 'ansi' then colour_ansi line, fg, bg
                 when 'extended' then colour_extended line, fg, bg
                 else raise "Unknown palette '#{@palette.type}'."
                 end

          line = e(1) + line if style.bright
          line = e(4) + line if style.underline
          line = e(5) + line if style.blink
          line = e(7) + line if style.inverse
          line = e(20) + line if style.fraktur
          line = e(51) + line if style.framed

          if (style.bright || style.underline || style.blink || style.inverse || style.fraktur || style.framed) && (fg == nil) && (bg == nil)
            line << e(0)
          end
        end

        output.push line
      end

      output << '' if string =~ /\n$/
      output.join "\n"
    end

    def get_style(name)
      raise "Style '#{name}' not found." unless @styles.key? name

      @styles[name]
    end

    def set_output(output_type)
      raise "Output '#{output_type}' not supported." unless %i[term raw].include? output_type

      @output_type = output_type
    end

    def get_best_font_colour(background)
      black = Tco::Colour.new([0, 0, 0])
      white = Tco::Colour.new([255, 255, 255])

      if background.is_a?(Colour) &&
         (background - black).abs < (background - white).abs
        return white
      end

      black
    end

    def get_colour_instance(value)
      if value.is_a?(String)
        resolve_colour_def value
      elsif value.is_a?(Symbol)
        resolve_colour_def value.to_s
      elsif value.is_a?(Array)
        Colour.new value
      elsif value.is_a?(Colour) || value.is_a?(Unknown)
        value
      elsif value == nil
        nil
      else
        raise "Colour value type '#{value.class}' not supported."
      end
    end

    private

    def e(seq)
      if @output_type == :raw
        "\\033[#{seq}m"
      else
        "\033[#{seq}m"
      end
    end

    def colour_ansi(string, fg = nil, bg = nil)
      unless fg == nil
        colour_id = if fg.is_a? Unknown
                      fg.id
                    else
                      @palette.match_colour(fg)
        end
        string = e(colour_id + 30) + string
      end

      unless bg == nil
        colour_id = if bg.is_a? Unknown
                      bg.id
                    else
                      @palette.match_colour(bg)
        end
        string = e(colour_id + 40) + string
      end

      string << e(0) unless (fg == nil) && (bg == nil)

      string
    end

    def colour_extended(string, fg = nil, bg = nil)
      unless fg == nil
        colour_id = if fg.is_a? Unknown
                      fg.id
                    else
                      @palette.match_colour(fg)
        end
        string = e("38;5;#{colour_id}") + string
      end

      unless bg == nil
        colour_id = if bg.is_a? Unknown
                      bg.id
                    else
                      @palette.match_colour(bg)
        end
        string = e("48;5;#{colour_id}") + string
      end

      string << e(0) unless (fg == nil) && (bg == nil)

      string
    end

    def parse_colour_id(id_in_string)
      id = String.new(id_in_string)
      if id[0] == '@'
        id[0] = ''
        return id.to_i
      end

      raise "Invalid colour id #{id_in_string}."
    end

    def parse_rgb_value(rgb_value_in_string)
      error_msg = "Invalid RGB value '#{rgb_value_in_string}'."
      rgb_value = String.new rgb_value_in_string
      if rgb_value[0] == '#'
        rgb_value[0] = ''
      elsif rgb_value[0..1] == '0x'
        rgb_value[0..1] = ''
      else
        raise error_msg
      end

      raise error_msg unless rgb_value =~ /^[0-9a-fA-F]+$/

      case rgb_value.length
      when 3
        rgb_value.scan(/./).map { |c| c.to_i 16 }
      when 6
        rgb_value.scan(/../).map { |c| c.to_i 16 }
      else
        raise error_msg
      end
    end

    def resolve_colour_name(name)
      raise "Name '#{name}' not found." unless @names.key? name

      @names[name]
    end

    def resolve_colour_def(colour_def)
      return nil if colour_def == '' || colour_def == 'default'

      begin
        id = parse_colour_id colour_def
        if @palette.is_known? id
          Colour.new @palette.get_colour_value id
        else
          Unknown.new id
        end
      rescue RuntimeError
        begin
          Colour.new parse_rgb_value colour_def
        rescue RuntimeError
          begin
            colour_def = resolve_colour_name colour_def
            if colour_def.is_a? String
              resolve_colour_def colour_def
            else
              colour_def
            end
          rescue RuntimeError
            raise "Invalid colour definition '#{colour_def}'."
          end
        end
      end
    end
  end
end
