require_relative 'style'
module TermGui
  # minimalist artificial screen cursor. TODO: cursor can be manipulated via ansi escape codes - see npm.org/blessed
  class Cursor
    attr_accessor :interval, :x, :y, :enabled, :off, :on

    def initialize(
      on_interval: 0.3, off_interval: on_interval / 2,
      x: 0, y: 0, enabled: false,
      #  by default we render the cursor next to its real x-coordinate
      x_offset: 1,
      screen: nil, off: ' ', on: '_',
      on_style: Style.new(bg: 'white', fg: 'black'), off_style: Style.new(bg: 'black', fg: 'white')
    )
      @x = x
      @y = y
      @on_interval = on_interval
      @off_interval = off_interval
      @enabled = enabled
      @x_offset = x_offset
      @screen = screen
      throw 'screen must be provided' unless @screen
      @state = 0
      @off = off
      @on = on
      @on_style = on_style
      @off_style = off_style
    end

    def enable
      disable
      @enabled = true
      @state = 0
      tick
    end

    def draw_off
      @screen.text(x: @x + @x_offset, y: @y, text: @off, style: @off_style)
    end

    def draw_on
      @screen.text(x: @x + @x_offset, y: @y, text: @on, style: @on_style)
    end

    def disable
      @enabled = false
      @screen.clear_timeout @timeout if @timeout
    end

    protected

    # renders the cursor according to its state, toggling the state and finally schedulling to call it self according to on_interval, off_interval
    def tick
      if @state == 0
        @state = 1
        draw_on
      elsif @state == 1
        @state = 0
        draw_off
      else
        throw 'unknown state ' + @state
      end
      @screen.clear_timeout @timeout if @timeout
      @timeout = @screen.set_timeout(@state == 0 ? @on_interval : @off_interval) { tick } if @enabled
    end
  end
end

Cursor = TermGui::Cursor
