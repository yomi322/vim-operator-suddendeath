scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim


function! operator#suddendeath#do(motion_wise)
  if a:motion_wise !=# 'line'
    echoerr 'operator-suddendeath supports linewise only'
    return
  endif
  let put = getpos("']")[1] == line('$') ? 'p' : 'P'
  execute 'normal!' '`[V`]"' . v:register . 'd'
  let str = split(getreg(v:register), '\n')
  call setreg(v:register, s:to_suddendeath(str), 'V')
  execute 'normal!' '"' . v:register . put
endfunction


function! s:to_suddendeath(str)
  let width = max(map(copy(a:str), 'strwidth(v:val)'))
  let mb_width = width / 2 + 1
  let suddendeath = '＿' . repeat('人', mb_width) . '＿' . "\n"
  for s in a:str
    let w = strwidth(s)
    let suddendeath .= '＞ ' . s . repeat(' ', width - w) . ' ＜' . "\n"
  endfor
  let suddendeath .= '￣' . repeat('^Y', mb_width) . '￣' . "\n"
  return suddendeath
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
