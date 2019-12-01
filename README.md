# termui

Command line user interface Ruby toolkit. Create desktop-like interfaces in the command line.

WIP

## development

```
bundle install
sh run test
sh run watch
```

## API example prototypes (WIP)

### layout & styles

TODO

### high level no layout

```
s=Screen.new
b=Button.new(parent: s.document, width: .3, height: .3, left: 0, top: 0, label: 'click me', onClick: { |e| alert "#{e.target.label} clicked!" })
s.render()
```

### example low level

```
screen, renderer = Screen.create
renderer.rect(2,3,9,3,'-', {fg: 'yellow', bg: 'gray'})
renderer.text(3,4,'click me', {fg: 'lightblue',bg: 'black' bold: true})
```

### events

```
s=Screen.new
s.document.addListener('key', {|e| exit 0 if e.key=='q'})
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

## Notes

### html canvas for renderer
 * try to stick to html canvas api for Renderer
 * user is responsible of setting the 'active style' like canvas' stroke-width - this simplifies renderer
