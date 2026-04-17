vim9script

import autoload 'partycursor.vim'

command! PartyCursor partycursor.Activate()
command! NoPartyCursor partycursor.Deactivate()
command! PartyCursorToggle partycursor.Toggle()

# vim: et sw=2 sts=-1
