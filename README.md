WIP

## concepts

Screen: contains document, renderer, InputEmitter

Renderer: responsible of drawing given pixels to the terminal

Buffer: maintains screen as bitmap structure (so users can read the current screen contents like a bitmap)

Document: Node subclass analog to html's (access to parent screen)

Node: DOM like representation analog to html's (children, attributes)

Element: Node subclass analog to html's (border, margin, padding)


## example prototypes

### example (high level no layout)

s=Screen.new
b=Button.new(parent: s.document, width: .3, height: .3, left: 0, top: 0, label: 'click me', onClick: { |e| alert "#{e.target.label} clicked!" })
s.render()

### example (layout & styles)

TODO

### example low level

screen, renderer = Screen.create
renderer.rect(2,3,9,3,'-', {fg: 'yellow', bg: 'gray'})
renderer.text(3,4,'click me', {fg: 'lightblue',bg: 'black' bold: true})

### events

s=Screen.new
s.document.addListener('key', {|e| exit 0 if e.key=='q'})
renderer.text(3,4,'click me', {fg: 'blue', bold: true})


## Notes

html canvas for renderer
 * try to stick to html canvas api for Renderer
 * user is responsible of setting the 'active style' like canvas' stroke-width - this simplifies renderer

Example Rect:

clearRect(x: number, y: number, w: number, h: number): void;
fillRect(x: number, y: number, w: number, h: number): void;
strokeRect(x: number, y: number, w: number, h: number): void;