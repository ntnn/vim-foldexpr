" vim-foldexpr
" Maintainer:	ntnn <nelo@wallus.de>
" Version:	1
" License:	MIT
" Website:	https://github.com/ntnn/vim-foldexpr

if exists("g:loaded_foldexpr") | finish | endif
let g:loaded_foldexpr = 1

if ! get(g:, 'foldexpr_disabled_ft', 0)
    let g:foldexpr_disabled_ft = []
endif
