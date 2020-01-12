# takes care of cursor related ansi escape sequences
module RendererCursor
  def cursor_save
    "#{CSI}s"
  end

  def cursor_restore
    "#{CSI}u"
  end

  def cursor_show
    "#{CSI}?25h"
  end

  def cursor_hide
    "#{CSI}?25l"
  end

  def cursor_shape(shape, blink = false)
    # from https://github.com/chjj/blessed/blob/master/lib/program.js#L1846
    output = ''
    if shape == 'block'
      if !blink
        output += '\x1b[0 q'
      else
        output += '\x1b[1 q'
      end
    elsif shape == 'underline'
      if !blink
        output += '\x1b[2 q'
      else
        output += '\x1b[3 q'
      end
    elsif shape == 'line'
      if !blink
        output += '\x1b[4 q'
      else
        output += '\x1b[5 q'
      end
    end
    output
  end
end
