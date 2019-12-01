# maps charsequences like '\n', '\e[1;7C' to objects like {name: 'enter'}, {name: 'right', control: true, meta: true}
# TODO: support meta-d ('\xC3': 'C-', '\xB0': 'C-') which is defined by two characters


charNames = {'\x01': 'C-a', '\x02': 'C-b', '\x03': 'C-c', '\x04': 'C-d', '\x05': 'C-e', '\x06': 'C-f', '\a': 'C-g', '\b': 'C-h', '\t': 'C-i', '\n': 'C-j', '\v': 'C-k', '\f': 'C-l', '\r': 'C-m', '\x0E': 'C-n', '\x0F': 'C-o', '\x10': 'C-p', '\x11': 'C-q', '\x12': 'C-r', '\x13': 'C-s', '\x14': 'C-t', '\x15': 'C-u', '\x16': 'C-v', '\x18': 'C-x', '\x19': 'C-y', '\x1A': 'C-z'} #TODO: C-w


def charToName ch
  if ch=='\n'
    'enter'
  elsif false
  else
  end
end

def decodeName(name)
  decoded={
    control: false,
    meta: false,
    shift: false,
    name: name
  }
  if a...z.include? name
  elsif false
  else
  end
end

@charNames={

'\e[A': 'up',
'\e[1;3A': 'M-up',
'e[1;2A': 'S-up',
'\e[1;6A': 'S-C-up',
'\e[1;7A': 'M-C-up',

'\e[B': 'down',
'\e[1;3B': 'M-down',
'e[1;2B': 'S-down',
'\e[1;6B': 'S-C-down',
'\e[1;7B': 'M-C-down',

'\e[D': 'left',
'\eb': 'M-left',
'e[1;2D': 'S-left',
'\e[1;6D': 'S-C-left',
'\e[1;7D': 'M-C-left',

'\e[C': 'right',
'\ef': 'M-right',
'e[1;2C': 'S-right',
'\e[1;6C': 'S-C-right',
'\e[1;7C': 'M-C-right',

'\e': 'esq',
'\r': 'enter',

# control-x
'\x01': 'C-a', '\x02': 'C-b', '\x03': 'C-c', '\x04': 'C-d', '\x05': 'C-e', '\x06': 'C-f', '\a': 'C-g', '\b': 'C-h', '\t': 'C-i', '\n': 'C-j', '\v': 'C-k', '\f': 'C-l', '\r': 'C-m', '\x0E': 'C-n', '\x0F': 'C-o', '\x10': 'C-p', '\x11': 'C-q', '\x12': 'C-r', '\x13': 'C-s', '\x14': 'C-t', '\x15': 'C-u', '\x16': 'C-v', '\x18': 'C-x', '\x19': 'C-y', '\x1A': 'C-z'

}

def nameToChar(name)
  # TODO: C-c, escape, enter, return, tab, left, 



  # \e[A up
  # \e[1;3A M-up
  # e[1;2A S-up
  # \e[1;6A S-C-up
  # \e[1;7A M-C-up

  # \e[B down
  # \e[1;3B M-down
  # e[1;2B S-down
  # \e[1;6B S-C-down
  # \e[1;7B M-C-down

  # \e[D left
  # \eb M-left
  # e[1;2D S-left
  # \e[1;6D S-C-left
  # \e[1;7D M-C-left
  
  # \e[C right
  # \ef M-right
  # e[1;2C S-right
  # \e[1;6C S-C-right
  # \e[1;7C M-C-right

  # \e esq
  # \r enter

  # \x10 C-p

end