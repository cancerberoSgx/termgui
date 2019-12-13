# termui

 * Command line graphical user interface Ruby toolkit. 
 * Create desktop-like interfaces in the command line.
 * Personal ruby-learning project right now
 * ncurses like library 100% ruby
 * some ideas taken from npm.org/blessed

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
screen.event.addKeyListener("s", Proc.new { |e| 
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

## development

```
bundle install
sh run test
sh run watch
```

## API example prototypes (WIP)

### layout & styles

TODO
```
require 'termgui'
class AppExplorer < Column
  def initialize(model)
    super
    @model=model
    @text=appendChild(Textarea.new model.text)
    @text.onChange {|e| print e.key}
  end
end
screen = Screen.new
main = Row.new
left = main.appendChild(Column.new 0.3)
right = main.appendChild(Column.new 0.7)
explorer = left.appendChild(AppExplorer.new model)
editor = right.appendChild(AppEditor.new model)
screen start
```

### high level no layout

TODO

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
screen.event.addListener('key', {|e| exit 0 if e.key=='q'})
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
  * supports user input events also like html dom EventSource (element.addListener('key', ...))
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
