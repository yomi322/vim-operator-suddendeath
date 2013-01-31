if exists('g:loaded_operator_suddendeath')
  finish
endif
let g:loaded_operator_suddendeath = 1

let s:save_cpo = &cpo
set cpo&vim


call operator#user#define('suddendeath', 'operator#suddendeath#do')


let &cpo = s:save_cpo
unlet s:save_cpo
