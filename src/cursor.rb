require_relative 'style'

# minimalist artificial screen cursor. TODO: cursor can be manipulated via ansi escape codes - see npm.org/blessed
class Cursor
  attr_accessor :interval, :x, :y, :enabled, :off, :on

  #  TODO: on_style off_style, on/off ch
  def initialize(interval: 0.3, x: 0, y: 0, enabled: false, screen: nil, off: ' ', on: '_')
    @x = x
    @y = y
    @interval = interval
    @enabled = enabled
    @screen = screen
    @state = 0
    @off = off
    @on = on
    throw 'screen must be provided' unless @screen
  end

  def enable
    disable
    @interval_listener = @screen.set_interval(@interval) { tick }
  end

  def tick
    if @state == 0
      @state = 1
      draw_on
    elsif @state == 1
      @state = 0
      @screen.text(x: @x, y: @y, text: @off)
    else
      throw 'unknown state ' + @state
    end
  end

def draw_on
  @screen.text(x: @x, y: @y, text: @on, style: Style.new(bold: true))
end
  def disable
    @enabled = false
    @screen.clear_interval @interval_listener if @interval_listener
    @interval_listener = nil
  end
end
