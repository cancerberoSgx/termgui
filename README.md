# termgui

 * Command line graphical user interface Ruby toolkit. 
 * Create desktop-like interfaces in the command line.
 * Personal ruby-learning project right now
 * 100% ruby, no binaries, no dependencies
 * some ideas taken from npm.org/blessed

 
### TODO / Status

 - [ ] make all character attributes work in style (see color.rb ATTRIBUTES)
 - [x] cli-driver for testing interactions / see probes/pty*
   - waitForData
 - [x] change camelCase to snake_case
 - [x] rubocop
 - [x] styled box drawing to string
 - [ ] support hash style declarations: `Element.new(x: 0.1, y: 0.2, style: {fg: 'magenta', border: {style: :double}})`
 - [ ] review callback's api and use yield, examples: `s.set_timeout(0.5){ p 'after'}` , `client.wait_for(proc { @ready }){ |timeout| p 'finished' unless timeout } ` - is it possible for set_timeout ? 
 - [x] element border using boxes 
     - [x] (box model different than html). 
     - [x] 1-size border support only. 
     - [x] border is a style on its own that by default equals its element's style.
 - [x] element's padding
 - [ ] store and formalize Element properties (initialize arguments). store it so implementations can look at original values given by user (props)
 - [ ] gem
   - [ ] minimally test gem pack from probe project
   - [ ] publish
 - [ ] element's margin
 - [ ] CursorManager - hide cursor - only show it when an input-box has focus by default
 - [ ] Layouts
   - [ ] So I don't need to specify element bounds: `col = Col.new; top = Row.new(height: 9,4); bottom= Row.new(height: 0.6); col.append_child(top, bottom)`
   - [ ] introduce yoga-layout ? are there any layout gems ? 
 - [ ] Keys : test support for key-names (C-x, S-C-right, escape, tab, etc) : `s.add_key_listener('S-C-right', proc {|ev|p 123})`
 - [ ] erb probe
 - [x] text rendering
   - [x] line wrap
   - [ ] justified,
   - [x] left
   - [ ] right, center (any gem for this?)
   - [ ] node.text_children - returns this node text plus all its children text recursively in children order (useful for testing)
 - [x] input.grab / ungrab
 - [x] focus manager
 - [x] set_timeout, set_interval
   - [ ] separate input@set_timeout in a module
 - [ ] wait_for/when : `screen.when( proc {element.query_one_by_attribute 'progress', 'ready'}, proc { print 'done' })`
 - [ ] element query cssish query support : `element.queryAll '[a="b"] .item > add-button'`
 - [ ] easing/animations : adapt formulas from accursed project
 - [ ] npm.org/inquirer like apis
 - [ ] promise like apis : `screen.wait_for(predicate1).then(proc {screen.wait_for(predicate2)}).then(verb2).catch(proc {|error|p error})` - right now is callback hell :(
   - [ ] based on our own event loop? or could we use a gem like concurrency?
 - [ ] text-box - how to lock focus ? how to implement the text-input experience ? 
 - [ ] more states like focus. right now only style.focus is supported. There's another state that could be simulated that is "enter" - when user presses enter a 1-second change is rendered with `style.enter` style. Every action (as in action.rb) should have its style.$action support. "escape" action could be similar to "enter"
## Status

 * WIP
 * drawing, styles, colors
 * input manager
 * renderer screen buffer (access screen like a bitmap)
 * no high level api yet

## Motivation

 * I didn't found ncurses/blessed library gem implemented 100% in ruby (only ncursed which is C BTW)
 * I'm the author of npm.org/accursed which is a similar library so I can of already implemented this in JavaScript
 * I'm getting started with ruby and I want to master it
 * Many helpers, mappings can be reused from npm.org since js objects are valid ruby maps {}
   * boxes: json
   * color names / mapping (js objects)
   * easing: simple js math-related functions easily to translate to ruby

## Usage
```
gem install termgui # TODO
```

// low level (working) example
```
require 'termgui'

screen = Screen.new

# install exit keys, by default 'q' will quit the program
screen.input.install_exit_keys

# when user press 's' we clear the screen and paint a rectangle full with 's' char
screen.event.add_key_listener("s", Proc.new { |e| 
  rect=Element.new 2,3,4,3,'S'
  screen.clear
  rect.render screen
})

# starts reading user input. 
screen.start
```


## Development commands

cd termui
bundler install
sh bin/test
sh bin/dev   # rails server
sh bin/watch # tests in watch mode



## API example prototypes (WIP)

** initial design stories**

### layout

TODO  / proposal

```
require 'termgui'
class AppExplorer < Column
  def initialize(model)
    super
    @model=model
    @text = append_child(text: Textarea.new model.text, onChange: {|e| print e.key})
    @text.onChange {|e| print e.key}
  end
end
screen = Screen.new
main = Row.new
left = main.append_child(Column.new 0.3)
right = main.append_child(Column.new 0.7)
explorer = left.append_child(AppExplorer.new model)
editor = right.append_child(AppEditor.new model)
screen start
```

### structure

TODO  / proposal

```
class MyWidget < Column
  def initialize
    super 0.5
    append_children [
      {type: Row, height: 0.6, children: [
        {type: Input, value: 'edit me', width: 0.5, onChange: {|e|print e} },
        {type: Label, text: 'edit me'},
      ]}
      {type: Button, text: 'click me', onClick: {|e|print e}},
    ]
  end
end
```

#### aside

```
{type: Button, text: 'click me', onclick: {|e|print e}},
vs
Button.new text: 'click me', onclick: {|e|print e}},

{type: Row, height: 0.6, children: [
  {type: Input, value: 'edit me', width: 0.5, onChange: {|e|print e} },
  {type: Label, text: 'hello'},
]}
vs
Row.new height: 0.6, children: [
  Input.new value: 'edit me', width: 0.5, onChange: {|e|print e},
  Label new: label: 'hello'
]
```

### style

style = {
  '.primary': {
    bg: 'red',
    fg: 'black'
    bold: true
  }
}
screen.append_child(Column.new children: [
  Label.new text: 'are you sure?',
  Button.new
])


### high level no layout

TODO / proposal

```
s=Screen.new
b=Button.new(parent: s.document, width: 0.3, height: 0.3, left: 0, top: 0, label: 'click me', onClick: { |e| alert "#{e.target.label} clicked!" })
s.start
```

### example low level

```
screen = Screen.new
screen.renderer.rect(2,3,9,3,'-', {fg: 'yellow', bg: 'gray'})
screen.renderer.text(3,4,'click me', {fg: 'lightblue',bg: 'black' bold: true})
```

### events

```
screen=Screen.new
screen.event.add_listener('key', {|e| exit 0 if e.key=='q'})
renderer.text(text: 'press q to exit')
```



## Design

### concepts

Screen: contains document, renderer, buffer, Input

Renderer: responsible of drawing given pixels to the terminal

Buffer: maintains screen as bitmap structure (so users can read the current screen contents like a bitmap)

Document: Node subclass analog to html's (access to parent screen)

Node: DOM like representation analog to html's (children, attributes)

Element: Node subclass analog to html's (border, margin, padding)

Input: responsible of user input - notifies screen - emitter

## Summary

I'm author of npm.org/flor that although has superior terminal support (tput) I would like to re implement a similar library for ruby, writing it from scratch (currently learning ruby). 

 * low level html-canvas like to set attributes and write strings
  * try to stick to html canvas api for Renderer
  * user is responsible of setting the 'active style' like canvas' stroke-width - this simplifies renderer
 * renderer of styled strings supporting cursor management, 
  *  responsible of translating user's `{bg: 'red', s: 'hello'}` into a string with ansi codes
 * screen maintains a virtual Buffer so current drawn screen can be accessed like a bitmap
 * a DOM like API for children, attributes, box model, style
  * supports user input events also like html dom EventSource (element.add_listener('key', ...))
  * basic widget implementations: button,input,textarea
 * style: fg, bg, ch, bold, etc. 

## Future

add features from npm.org/flor: 

 * event manager
 * focus manager
 * scroll (element.scrollX=0.2) - dom support
 * a xmlish syntax for defining GUI. 
  * support function attributes for event handlers

## Side projects

 * cli/driver for ruby : for properly testing termgui we need cli-driver for ruby. see probes/stdin.rb for working exec and writing to process stdin async 

## Notes

### html canvas for renderer
 * try to stick to html canvas api for Renderer
 * user is responsible of setting the 'active style' like canvas' stroke-width - this simplifies renderer

### ideas

make a more react-like API besides this one based on HTML DOM. User pass props and children: 

```
screen.append_child Col.new {className: 'container', style: {bg: 'green'}}, [
  TextArea.new {text: @value, onEnter: proc {|e|p e}},
  Row.new {}, [
    Button.new {text: 'Accept', onEnter: proc: {}, class: 'primary' },
    Button.new {text: 'Cancel', onEnter: proc {exit}}
  ]
]
```
