require_relative '../../src/widget/modal'
require_relative '../../src/termgui'
require_relative '../../src/util/unicode-categories'

module AppHandlers 

  def handle_state
    text = "
The following is the current state of this application, since the UI is a mess :P
Unicode Category: #{state.chs}
File: #{state.current_file}
Original Image Dimensions: #{image_widgets[state.current].original_image.width}x#{image_widgets[state.current].original_image.height} pixels
Current Image Dimensions: #{image_widgets[state.current].current_image.width}x#{image_widgets[state.current].current_image.height} pixels
      "
    open_modal(
      title: 'Current State',
      screen: screen,
    content:  Col.new(width: 0.8, height: 0.8, children: [Label.new(text: 'Welcome', style: { blink: true, bold: true, underline: true, fg: 'red' })].concat(text.split("\n").map { |line| Label.new(text: line, width: MAX, style: Style.new(wrap: true, padding: Bounds.new(left: 4))) }))
    )
  end

  def handle_help
    text = "
This is really a toy for learning Ruby
No mouse - only keys:
'tab': focus next button
'shift-tab': focus previous button
'+': zoom_in
'-': zoom_out
'left': prev
'right': next
'w': pan_up
's': pan_down
'd': pan_right
'a': pan_left
'b': brush_selection
      "
    open_modal(
      title: 'Help',
      screen: screen,
    content:  Col.new(width: 0.8, height: 0.8, children: [Label.new(text: 'Some guidance', style: { blink: true, bold: true, underline: true, fg: 'red' })].concat(text.split("\n").map { |line| Label.new(text: line, width: MAX, style: Style.new(wrap: true, padding: Bounds.new(left: 4))) }))
    )
  end

  def handle_brush
    if @brush_select
      @brush_select&.remove
      screen.append_child(@brush_select)
    else
      @brush_select ||= SelectBox.new(
        x: 0.2,
        y: 0.01,
        width: 30,
        height: 0.9,
        parent: screen,
        options: UNICODE_CATEGORIES.keys.map do |k|
          {
            value: k,
            text: k.to_s
          }
        end,
        input: proc {
          @brush_select.remove
          handle_brush_selection @brush_select.value&.sample
        }
      )
    end
    screen.clear
    @brush_select.focus
    @brush_select.render
  end

  def handle_brush_selection(sel =  UNICODE_CATEGORIES.keys.sample)
    return unless sel
    state.chs = sel 
    log "Brush #{state.chs}"
    image_widgets[state.current].chs = UNICODE_CATEGORIES[state.chs]
    render_current
    screen.clear
    screen.render
  end

  def handle_next
    if state.current < state.files.length - 1
      state.current += 1
      render_current
    else
      screen.alert
    end
  end

  def handle_prev
    if state.current > 0
      state.current -= 1
      render_current
    else
      screen.alert
    end
  end

  def handle_zoom_in
    image_widgets[state.current].zoom = [image_widgets[state.current].zoom - 0.1, 0.0].max
    image_widgets[state.current].refresh(true)
  end

  def handle_zoom_out
    image_widgets[state.current].zoom = [image_widgets[state.current].zoom + 0.1, 10.0].min
    image_widgets[state.current].refresh(true)
  end

  def handle_pan_right
    image_widgets[state.current].pan_x = [image_widgets[state.current].pan_x + 0.1, 1.0].min
    image_widgets[state.current].refresh(true)
  end

  def handle_pan_left
    image_widgets[state.current].pan_x = [image_widgets[state.current].pan_x - 0.1, 0.0].max
    image_widgets[state.current].refresh(true)
  end

  def handle_pan_up
    image_widgets[state.current].pan_y = [image_widgets[state.current].pan_y - 0.1, 0.0].max
    image_widgets[state.current].refresh(true)
  end

  def handle_pan_down
    image_widgets[state.current].pan_y = [image_widgets[state.current].pan_y + 0.1, 1.0].min
    image_widgets[state.current].refresh(true)
  end

  def handle_load(e)
    open_modal(screen: screen, content: 'Not implemented yet', title: 'Error')
    screen.alert
    # if !File.exist?(file_name.value)
      # open_modal(screen: screen, content: 'The File does not exists', title: 'Error')
    # else
    #   e.target.text = 'Loading...'
    #   e.target.render
    #   img.src = file_name.value
    #   img.render
    #   e.target.clear
    #   e.target.text = 'Load'
    #   e.target.render
    # end
  end
end

