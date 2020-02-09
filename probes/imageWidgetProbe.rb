
require_relative '../src/termgui'
require_relative '../src/util'
imgs = nil
s = Screen.new(
  children: [
    Button.new(text: 'hello', x: 0.7, y: 0.6, action: proc { |e|
      imgs ||= `ls probes/assets/bas*.png`.split("\n").shuffle.map{|f|
      Image.new(
        render_cache: true,
        x: random_float(0.1, 0.6),
        y: random_float(0.1, 0.6),
        width:  random_float(0.4, 0.7),
        height:  random_float(0.5, 0.7),
        src:f,
        parent: s,
        # transparent_color:'#000000'
        style: Style.new(
          # border: Border.new(fg: '#aaaa77', bg: '#ee2233', blink: true),
          # padding: Bounds.new(top: random_float(0.1, 0.2), left: random_float(0.1, 0.2), right: random_float(0.1, 0.2), bottom: random_float(0.1, 0.2)),
          bg: random_color,
          # fg: random_color
        )
        # use_bg: true,
        # use_fg: true,
        # ch: ' '
        # ch: "　",
        # ch: ' '
      )}
      s.clear
      t0 = Time.now
      imgs.each {|i|i.render}
      text = "rendered in #{print_ms(t0)}"
      s.text(x: random_int(1, s.width - 20), y: random_int(1, s.height - 3), text: text)
      e.target.x = random_int(1, s.width - 20)
      e.target.y = random_int(1, s.height - 3)
      e.target.text = text
      e.target.render
    })
  ]
)
s.start
