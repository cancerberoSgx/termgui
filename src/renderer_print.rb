require_relative 'style'
require_relative 'key'

# takes care of printing renderer buffer in different ways
module RendererPrint
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
end
