" vim-foldexpr
" Maintainer:	ntnn <nelo@wallus.de>
" Version:	1
" License:	MIT
" Website:	https://github.com/ntnn/vim-foldexpr

if exists("g:loaded_foldexpr") | finish | endif
let g:loaded_foldexpr = 1

if ! get(g:, 'foldexpr_ft_disabled', 0)
    let g:foldexpr_ft_disabled = []
endif

if ! get(g:, 'foldexpr_fold_disabled', 0)
    let g:foldexpr_fold_disabled = []
endif

if ! get(g:, 'foldexpr_text_disabled', 0)
    let g:foldexpr_text_disabled = []
endif

if ! get(g:, 'foldexpr_ft_equivalent', 0)
    let g:foldexpr_ft_equivalent = {
                \ 'go': 'c'
                \ }
endif

filetype on

aug foldexpr
    au!
    au FileType * call foldexpr#apply_settings()
aug END
