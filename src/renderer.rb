# frozen_string_literal: true

require_relative 'style'
require_relative 'key'

# Responsible of (TODO: we should split Renderer into several delegate classes
#  * build charsequences to render text on a position. these are directly write to $stdout by screen
#  * maintain bitmap-like buffer of current screen state
#  * manages current applied style
# TODO: add line, empty-rect and more drawing primitives
class Renderer
  attr_reader :width, :height, :buffer, :style

  def initialize(width = 80, height = 20)
    @width = width
    @height = height
    @buffer = (0...@height).to_a.map do
      (0...@width).to_a.map do
        Pixel.new Pixel.EMPTY_CH, Style.new
      end
    end
    @style = Style.new
  end

  # all writing must be done using me
  def write(x, y, ch)
    if y < @buffer.length && y >= 0
      (x...[x + ch.length, @width].min).to_a.each do |i|
        @buffer[y][i].ch = ch[i - x]
      end
      # style = @style==nil ? '' : @style.print
      # if style != @last_style
      #   @last_style = style
      # end
      # "#{style}#{move x, y}#{ch}"
      "#{move x, y}#{ch}"
    else
      ''
    end
  end

  # def writeStyle
  #   @style.print
  # end

  # prints current buffer as string
  def print
    s = ''
    @buffer.each_index do |y|
      @buffer[y].each do |p|
        s += p.ch
      end
      s += '\n'
    end
    s
  end

  def print_rows
    rows = []
    @buffer.each_index do |y|
      line = ''
      @buffer[y].each do |p|
        line += p.ch
      end
      rows.push(line)
    end
    rows
  end

  def move(x, y)
    "#{CSI}#{y};#{x}H"
  end

  def rect(x: 0, y: 0, width: 5, height: 3, ch: Pixel.EMPTY_CH)
    s = ''
    height.times do |y_|
      s += write(x, y + y_, ch * width).to_s
    end
    s
  end

  def save_cursor
    "#{CSI}s"
  end

  def restore_cursor
    "#{CSI}u"
  end

  def clear
    @style = Style.new
    @buffer.each_index do |y|
      @buffer[y].each do |p|
        p.ch = Pixel.EMPTY_CH
        p.style.reset
      end
    end
    "#{CSI}0m#{CSI}2J"
  end

  attr_writer :style

  def style_assign(style)
    @style.assign(style)
  end
end

class Pixel
  attr_reader :ch, :style

  def self.EMPTY_CH
    ' '
  end

  def initialize(ch = Pixel.EMPTY_CH, style = Style.new)
    @ch = ch
    @style = style
  end

  attr_writer :ch

  attr_writer :style
end
