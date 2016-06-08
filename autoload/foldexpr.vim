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
    if ! filereadable(s:autoload . 'foldexpr/' . &filetype . '.vim')
        return
    endif

    let prefix = 'foldexpr#' . &filetype . '#'

    if index(g:foldexpr_fold_disabled, &filetype) == -1
        setl foldmethod=expr
        exec 'setl foldexpr=' . prefix . 'fold()'
    endif

    if index(g:foldexpr_text_disabled, &filetype) == -1
        let prefix .= 'text()'
        " try calling the text() function, if that throws an error
        " the function doesn't exist and the default will be set
        try
            silent exec 'call ' . prefix
            silent exec 'setl foldtext=' . prefix
        catch /E117/
            setl foldtext=foldexpr#text()
        endtry
    endif
endfunction
