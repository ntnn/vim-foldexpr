" vim-foldexpr
" Maintainer:	ntnn <nelo@wallus.de>
" Version:	1
" License:	MIT
" Website:	https://github.com/ntnn/vim-foldexpr

let s:autoload = expand('<sfile>:p:h:h') . '/autoload/'

function foldexpr#text()
    return getline(v:foldstart)
endfunction

function foldexpr#apply_settings()
    if index(g:foldexpr_ft_disabled, &filetype) >= 0
        return
    endif

    " check that a foldmethod for that filetype exists
    let path = 'foldexpr/' . &filetype . '.vim'
    if ! filereadable(s:autoload . path)
        return
    endif

    " and load it to check for its functions
    exec 'runtime ' . path

    if index(g:foldexpr_fold_disabled, &filetype) == -1
        setl foldmethod=expr
        exec 'setl foldexpr=foldexpr#' . &filetype . '#fold()'
    endif

    if index(g:foldexpr_text_disabled, &filetype) == -1
        let func = 'foldexpr#' . &filetype . '#text()'
        if exists('*' . func)
            exec 'setl foldtext=' . func
        else
            setl foldtext=foldexpr#text()
        endif
    endif
endfunction
