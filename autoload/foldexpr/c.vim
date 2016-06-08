" vim-foldexpr
" Maintainer:	ntnn <nelo@wallus.de>
" Version:	1
" License:	MIT
" Website:	https://github.com/ntnn/vim-foldexpr

" matches '} else {' and '} else if (...) {'
let s:fold_else = '} else'
let s:fold_doc_start = '/\*\{1,2}'
let s:fold_doc_end = '\*/'
let s:fold_doc_oneline = s:fold_doc_start . '.*' . s:fold_doc_end
let s:fold_typedef = 'typedef .* {'

function! foldexpr#c#fold()
    let pl = getline(v:lnum - 1)
    let l = getline(v:lnum)
    let nl = getline(v:lnum + 1)

    " fold close fold before '} else'
    if nl =~ s:fold_else
        return 's1'
    endif

    " do not fold single line compounds
    if l !~ '{.*}'
        if l =~ '{'
            return 'a1'
        elseif l =~ '}' && l !~ s:fold_else
            " ignore:
            " } else
            "     stuff();
            return 's1'
        endif
    endif

    if l !~ s:fold_doc_oneline
        if l =~ s:fold_doc_start
            return 'a1'
        endif

        if l =~ s:fold_doc_end
            return 's1'
        endif
    endif

    return '='
endfunction

function! foldexpr#c#text()
    let l = getline(v:foldstart)

    if l =~ s:fold_typedef && l !~ ';$'
        " typedef struct {} name;
        return l . getline(v:foldend)
    elseif l =~ s:fold_doc_start . '\s*$'
        return getline(v:foldstart + 1)
    endif

    return l
endfunction
