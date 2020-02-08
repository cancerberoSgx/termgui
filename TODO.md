## TODO

 - [ ] advance focus
   - [ ] how to support focus hierarchies ? 
     - [ ] alternative 1: use tabs to focus primary panels and arrows to focus internal widgets of current first level focused panel 
     - [ ] alternative 2: make a focusable & enterable - when entered focus-keys will only work inside it (focusing focusable children)
     
 - [w] editor - generic text area like (see section "editor" below). See src/editor

 - [ ] investigate similar target projects 
    - [ ] https://github.com/Shopify/cli-ui 
    - [ ]  https://github.com/gavinlaking/vedeu
    - [ ] input - check this - https://github.com/piotrmurach/tty-reader supports raw mode for multi line - "https://github.com/piotrmurach/tty-reader#22-read_line" - has the key map implemented.
    - [ ] keys - full map verify https://rubydoc.info/gems/vedeu/Vedeu
    - [ ] check this out - terminal toolkit - many things needed here - research if it targets the same use cases https://ttytoolkit.org/components/

 - [ ] scroll 
   - [x] Element#offset
   - [ ] ScrollManager : define "scrollable" and define keys for scroll up, down, left right if current focused el is scrollable ? (manager?)
     - [ ] scroll events
     - [ ] need overflow: hidden to make sense - see probes/fileProbe.rb 
       - [ ] renderer should prevent children content outside overflow:hidden ancestors (expensive render)
     - [ ] configurable scroll keys, offset amounts and easing, globally and per element.
   - [ ] inspiration perhaps : https://github.com/xunker/peter_pan/blob/master/lib/peter_pan.rb

 - [ ] test coverage : https://github.com/colszowka/simplecov


 - [ ]  colors:
  - [x] verify character attributes work in style (see color.rb ATTRIBUTES  Update - removed ). - 
    - [x] test in a realProbe
    - [x]  Update: using src/tco now but don0t support all - checkout https://github.com/sickill/rainbow and https://github.com/fazibear/colorize  and https://github.com/piotrmurach/pastel - update - tco fixed 
      - [ ] TODO: tco pull request 

 - [ ] how to debug ? check if this could help debugging

 - [ ] DOM stuff
  - [ ] bounds/layout cascade ? 
  - [x] border_final_style
  - [ ] final_style performance - always cloning/merging even if elements don't have any focus or border style...
  - [x] fix HashObject#assign so it won't merge nil valued properties. see element_style#merge_style
  - [x] support hash style declarations: `Element.new(x: 0.1, y: 0.2, style: {fg: 'magenta', border: {style: :double}})`
  - [x] CSS cascade style: children should inherit parent style if explicit and child has no value. (make it optional/configurable) (see `element.get_attribute('style-cascade') == 'prevent'`)
  - [ ] store and formalize Element options (initialize arguments). store it so implementations can look at original values given by user (props)
  - [ ] overflow: hidden
  - [ ] overflow: scroll
  - [x] Element#layout() 
  - [ ] widgets Col and Row (not working correctly)
    - [ ] check https://rubydoc.info/gems/terminal-layout
    - [ ] element's margin
    - [ ] introduce yoga-layout ? (binary)
    - [ ] are there any layout gems ? 

 - [ ] gem
   - [ ] minimally test gem pack from probe project
   - [ ] publish
   - [ ] check this helper: https://github.com/technicalpickles/jeweler

 - [ ] cursor
   - [x] simple cursor artificial class set_interval see src/cursor.rb
   - [ ] use ansi escapes - https://github.com/piotrmurach/tty-cursor for cursor_current state
   - [x] hide when screen.start
   - [ ] widgets responsible of showing/hiding ? or should it be a cursor manager - enterable - cursorable attributes  ? 

 - [ ] data table widget https://www.google.com/search?q=ruby+gem+terminal&oq=ruby+gem+terminal&aqs=chrome..69i57j69i64.3455j0j4&sourceid=chrome&ie=UTF-8#

 - 
 - [ ] documentation
   - [x] generate API documentation (using yard)
   - [ ] publish docs/termgui to github pages
   - [ ] add links to important APIs in README
   - [ ] document important APIs - how to document events and DOM attributes as part of the API docs? 
   - [ ] screencasts, screenshots (check http://buildkite.github.io/terminal-to-html/) - asciicam-thing
   - [ ] tutorials
   - [ ] examples using only low level apis (Input, Renderer) without DOM 
   - [ ] announce in stack overflow, medium articles like https://medium.com/@bryantteng/outputting-to-the-terminal-in-style-f489bc2fa52c - 

 - [x] erb probe for elements (see xml/xml)
 - [x] xml syntax with binding support
   - [x] properly require '/Users/wyeworks/.rubies/ruby-2.6.5/lib/ruby/2.6.0/rexml/document'
   - [x] access self (the element instance) from attribute handlers: `action="proc {|e| e.target.text = 'asdasd'; e.target.render}"`
   - [ ] complete widgets and attributes - padding, border, style.focus, stc

 - [ ] fonts with http://www.figlet.org/ - https://github.com/miketierney/artii - also check http://github.com/piotrmurach/tty-font
 
 - [ ] terminal capabilities http://github.com/piotrmurach/tty-color

 - [ ] image rendering 
   - [ ] try not to use binary dependencies like RMagick:  https://github.com/nodanaonlyzuul/asciiart/blob/master/asciiart.gemspec - this other project is not so old also rely on rmagick https://github.com/nathanpc/ascii-image -  also this https://github.com/pazdera/catpix
   - [ ] pure ruby https://github.com/wvanbergen/chunky_png maintained project - see https://github.com/wvanbergen/chunky_png/blob/master/spec/chunky_png/canvas_spec.rb -
   
 - [w] text rendering - use this : https://github.com/piotrmurach/strings#21-align
   - [x] line wrap
   - [ ] justified, https://rubydoc.info/gems/justify
   - [x] left
   - [ ] right, center (any gem for this?)
   - [ ] node.text_children or all_text - returns this node text plus all its children text recursively in children order (useful for testing)

 - [ ] fix duplicated Event class ... see emitter.rb : " this is the same as event.rb Event. Move Event classes to individual - non dependency file"

 - [w] easing/animations : adapt formulas from accursed project - see src/util/easing.rb

 - [w] npm.org/inquirer like apis - see /inquirer
 
 - [ ] promise like apis : `screen.wait_for(predicate1).then(proc {screen.wait_for(predicate2)}).then(verb2).catch(proc {|error|p error})` - right now is callback hell :(
     - [x] Could RUby's then() help here ? ANSWER: NO
   - [ ] based on our own event loop? or could we use a gem like concurrency? update - currently supporting method block which is similar ?

 - [w] element query cssish query support : `element.queryAll '[a="b"] .item > add-button'`
   - [x] query_by_attribute, query_one_by_attribute
   - [x] CSS like language parser
   - [ ] query engine based on css like language below. 
   - [ ] stylesheets CSS like for declare styles. Can we use ruby based language instead of CSSish ? 

   
### Done

 - [x] wait_for/when : `screen.when( proc {element.query_one_by_attribute 'progress', 'ready'}, proc { print 'done' })`
 - [x] issue when pipe to file, i.e. ruby a_screen_start_app.rb > file.txt `screen.rb:22:in winsize': Inappropriate ioctl for device (Errno::ENOTTY)`
 - [x] renderer.buffer disabled by default (faster) - Screen.new_for_testing will enable buffer and silent screen.
 - [x] renderer methods accepts style and always print "closed" styled strings.
 - [w] Layouts
   - [x] So I don't need to specify element bounds: `col = Col.new; top = Row.new(height: 9,4); bottom= Row.new(height: 0.6); col.append_child(top, bottom)`
 - [x] text-box - how to lock focus ? how to implement the text-input experience ? WIP see src/widget/textbox
 - [w] set_timeout, set_interval
   - [x] separate input@set_timeout in a module
   - [x] support set_interval correctly - test it
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

- [x] put everything inside module TermGui
  - [x] group widget hight -level in TermGui::Widget 
  - [x] an export * file - see termgui.rb
   
 - [x] Keys : test support for key-names 
   - [x] test names - enter, left,up, right down, escape
   - [x]  test complex (C-x, S-C-right, escape, tab, etc) : `s.add_key_listener('S-C-right', proc {|ev|p 123})`


### Editor TODO

I didn't saw this implemented in similar libraries like tty-reader, vedeu or shopify-cli ( tty-reader mentions multiline editor bur is not this...  this is like terminal prompt - not text area) 

Current status: implements a text area supporting configurable set of keys arrows, enter, backspace, delete, home, end, next-page, prev-page, tab, shift-tab. The basics are there, a text area could be implemented currently easily. 


But what about a "real world" editor and which feature should be responsibility of this library?

* should this be in a separate project ? 

* filesystem

* selection  : shift arrows, shift-end,  C-a, etc
  * this impacts on handle_keys since if there's a selection, 
    * modifications will replace the selection. 
    * arrows - navigation changes semantics

* basic text buffer - TextChange, span, etc this will enable:
  * undo-redo 
  * change notifications
  * big buffers

* clipboard ? system clipboard ? 

* MISSING KEYS: shift-tab, home, end, next-page, prev-page - these are not supported in keys currently

* scrolling for lines outside area
  * alternatively implement word wrap -
  * ideally we want both (toggle word wrap)
  * right now text is truncated on the right and bottom.

* configurable key-shortcuts - ideally we should be able to move, scroll, undo, redo, copy, etc a-la-vim with just config

* UX we will need to ESCAPE to activate menus - like vim... or should we support complex key-shortcuts like emacs?
  * ideally I want a menu that is activated with escape . escape or action to enter in the editor... 
  * in the future other widgets like folder explorer can be escape-tab to focus escape-tab enter to enter the editor again ? or the menu? like blessed/blessed-based-editor...

* file chooser - save/load files visually
* projects:
  * multiple buffers (tabs?) opened
  * file explorer - tree showing a folder allowing opening files - some actions like remove , rename, move ? visually!
    * implies kind of MVC - an open file renamed

#### current editor_base implementation todo

  *  TODO: maybe is better to extend Element and use its coords and root_screen? or have a CursorElement or EnterableElement with cursor stuff? Maybe also move all this to a module instead of class
    *  x, y accessors should support percents - or we should just call abs_content_x, etc
    *  enable() should be called on_enter, disable() on_blur or on_escape
    *  render() should call super and compatible with element
    *  width, height - currently will print stuff outside screen 
      * line break - word wrap ? 
      *   if no linebreak then we need a viewport for "scrolling" - if not is not usable for a text editor (can we leave this reponsibility to container Element - don't think so - another reason to make this an Element?)

  *  won't work for tab (currently hacking) and unicode chars width != 1
  

#### editor plan

 * implement editor API only nothing visual but the text area: 
