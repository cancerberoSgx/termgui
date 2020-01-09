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

  # prints to stdout a representation in ruby string concatenated syntax so its easy for devs copy&paste for test asserts
  def print_dev_stdout
    print.split('\\n').each { |line| puts "'#{line}\\n' + " }
  end

  def print_dev
    s = "'' + \n"
    print.split('\\n').each { |line| s = "#{s}'#{line}\\n' + \n" }
    s + "''"
  end
end
