" vim-foldexpr
" Maintainer:	ntnn <nelo@wallus.de>
" Version:	1
" License:	MIT
" Website:	https://github.com/ntnn/vim-foldexpr

if index(g:foldexpr_disabled_ft, 'python') == -1
    setl foldmethod=expr
    setl foldexpr=foldexpr#python#fold()
    setl foldtext=foldexpr#python#text()
endif
