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

end
