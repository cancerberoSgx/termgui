require_relative 'colouring'
require_relative 'config'

module TermGui
  @colouring_config = Tco::Config.new
  @colouring = Tco::Colouring.new @colouring_config

  def self.open_style(style, colouring = @colouring)
    s = colouring.decorate('__', style)
    s = s.slice(0, s.length - 4 - 2)
    s
  end

  def self.close_style(_colouring = @colouring)
    @colouring.decorate('', TermGui::Style.new(fg: 'red', bg: 'red', bold: true, underline: true))
  end

  def self.print(s, style)
    @colouring.decorate(s, style)
  end

  def self.fast_colouring(value)
    Tco::Colour.fast = value
    @colouring.palette.reset_cache
  end
end
