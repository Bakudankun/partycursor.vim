vim9script

var hue: number
var timer: number
var save_gcr: string = null_string
var save_hl: list<dict<any>>

def Update(_: number)
  hue += 64
  hue %= 1536
  var r: number = abs(hue - 768) - 256
  var g: number = abs(Mod((hue - 512), 1536) - 768) - 256
  var b: number = abs(Mod((hue - 1024), 1536) - 768) - 256
  r = max([min([r, 255]), 0]) / 2 + 128
  g = max([min([g, 255]), 0]) / 2 + 128
  b = max([min([b, 255]), 0]) / 2 + 128
  hlset([{
    name: 'Cursor',
    guifg: '#000000',
    guibg: printf("#%02x%02x%02x", r, g, b),
  }])
enddef

def Mod(a: number, b: number): number
  return a >= 0 ? a % b : a % b + b
enddef

export def Activate()
  Deactivate()
  timer = timer_start(15, Update, {repeat: -1})
  save_gcr = &guicursor
  save_hl = hlget('Cursor')
  :set guicursor+=n-v-c:blinkon0
enddef

export def Deactivate()
  if !!timer_info(timer)
    timer_stop(timer)
  endif
  if save_gcr != null_string
    &guicursor = save_gcr
  endif
  if !!save_hl
    hlset(save_hl)
  endif
  timer = 0
  save_gcr = null_string
  save_hl = []
enddef

export def Toggle()
  if !!timer_info(timer)
    Deactivate()
  else
    Activate()
  endif
enddef

# vim: et sw=2 sts=-1
