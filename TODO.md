## TODO

 - scroll - viewport - inspiration perhaps : https://github.com/xunker/peter_pan/blob/master/lib/peter_pan.rb
 test coverage : https://github.com/colszowka/simplecov
 rubygem : https://github.com/technicalpickles/jeweler
generate documentation (using yard)
 colors: check out this other library supporting all ansi attrs: https://github.com/fazibear/colorize probably don't need hacking for keep escape open
 - [ ] verify character attributes work in style (see color.rb ATTRIBUTES). Status: bold and others are working but didn't exhaustively test them. Update: using src/tco now
  - [ ] test in a realProbe
 - [ ] how to debug ? check if this could help debugging
 - [ ] anounce in stackoverflow, medium articles like https://medium.com/@bryantteng/outputting-to-the-terminal-in-style-f489bc2fa52c
 - [ ] border_final_style
 - [ ] final_style performance - always cloning/merging even if elements don't have any focus or border style...
 - [x] fix HashObject#assign so it won't merge nil valued properties. see element_style#merge_style
 - [ ] support hash style declarations: `Element.new(x: 0.1, y: 0.2, style: {fg: 'magenta', border: {style: :double}})`
 - [ ] CSS cascade style: children should inherit parent style if explicit and child has no value. (make it optional/configurable)
 - [ ] store and formalize Element properties (initialize arguments). store it so implementations can look at original values given by user (props)
 - [ ] gem
   - [ ] minimally test gem pack from probe project
   - [ ] publish
 - [ ] element's margin
 - [ ] CursorManager - hide cursor - only show it when an input-box has focus by default
   - [ ] introduce yoga-layout ? are there any layout gems ? 
 - [ ] Keys : test support for key-names (C-x, S-C-right, escape, tab, etc) : `s.add_key_listener('S-C-right', proc {|ev|p 123})`
 - [ ] erb probe
 - fonts with http://www.figlet.org/ - https://github.com/miketierney/artii - demo
 - images - RMagick + tco - example somewhere very easy but magick is binary - 
   - these gem uses rmagick - https://github.com/nodanaonlyzuul/asciiart/blob/master/asciiart.gemspec - this other project is not so old also rely on rmagick https://github.com/nathanpc/ascii-image -  also this https://github.com/pazdera/catpix
   - pure ruby https://github.com/wvanbergen/chunky_png maintained project - see https://github.com/wvanbergen/chunky_png/blob/master/spec/chunky_png/canvas_spec.rb -
 - [w] text rendering
   - [x] line wrap
   - [ ] justified,
   - [x] left
   - [ ] right, center (any gem for this?)
   - [ ] node.text_children - returns this node text plus all its children text recursively in children order (useful for testing)
 - see emitter.rb : " this is the same as event.rb Event. Move Event classes to individual - non dependency file"
 - [w] set_timeout, set_interval
   - [x] separate input@set_timeout in a module
   - [ ] support set_interval correctly - test it
 - [ ] wait_for/when : `screen.when( proc {element.query_one_by_attribute 'progress', 'ready'}, proc { print 'done' })`
 - [ ] easing/animations : adapt formulas from accursed project
 - [w] npm.org/inquirer like apis
 - [ ] promise like apis : `screen.wait_for(predicate1).then(proc {screen.wait_for(predicate2)}).then(verb2).catch(proc {|error|p error})` - right now is callback hell :(
   - [ ] based on our own event loop? or could we use a gem like concurrency?
 - [ ] text-box - how to lock focus ? how to implement the text-input experience ? 

### Done

 - [x] issue when pipe to file, i.e. ruby a_screen_start_app.rb > file.txt `screen.rb:22:in winsize': Inappropriate ioctl for device (Errno::ENOTTY)`
 - [w] Layouts
   - [x] So I don't need to specify element bounds: `col = Col.new; top = Row.new(height: 9,4); bottom= Row.new(height: 0.6); col.append_child(top, bottom)`
 - [x] cli-driver for testing interactions / see probes/pty*
   - [x] waitForData
 - [x] change camelCase to snake_case
 - [x] rubocop
 - [x] styled box drawing to string
 - [x] review callback's api and use yield, examples: `s.set_timeout(0.5){ p 'after'}` , `client.wait_for(proc { @ready }){ |timeout| p 'finished' unless timeout } ` - is it possible for set_timeout ? 
 - [x] element border using boxes 
     - [x] (box model different than html). 
     - [x] 1-size border support only. 
     - [x] border is a style on its own that by default equals its element's style.
 - [x] element's padding
 - [x] input.grab / ungrab
 - [x] focus manager
 - [w] element query cssish query support : `element.queryAll '[a="b"] .item > add-button'`
   - [x] query_by_attribute, query_one_by_attribute
   - [x] CSS like language parser
   - [ ] query engine based on css like language below. 


### Ideas - nice to have

 - [ ] more states like focus. right now only style.focus is supported. There's another state that could be simulated that is "enter" - when user presses enter a 1-second change is rendered with `style.enter` style. Every action (as in action.rb) should have its style.$action support. "escape" action could be similar to "enter"


## Status

 * WIP
 * See TODO
 * drawing, styles, colors
 * input manager
 * renderer screen buffer (access screen like a bitmap)
 * no high level api yet
