" vim-foldexpr
" Maintainer:	ntnn <nelo@wallus.de>
" Version:	1
" License:	MIT
" Website:	https://github.com/ntnn/vim-foldexpr

let s:space = '\v^\s*\\'
let s:fold_docclass = s:space . 'documentclass'
let s:fold_beginblock = s:space. 'begin\{'
let s:fold_endblock = s:space . 'end\{'
let s:fold_begindoc = s:fold_beginblock. 'document\}'
let s:fold_enddoc = s:fold_endblock 'document\}'
let s:folds = [
            \ 'part',
            \ 'chapter',
            \ 'section',
            \ 'subsection',
            \ 'subsubsection',
            \ 'paragraph',
            \ 'subparagraph',
            \ ]

function foldexpr#tex#fold()
    let l = getline(v:lnum)
    let nl = getline(v:lnum +  1)

    if nl =~ s:fold_begindoc
        return '<1'
    endif
    if l =~ s:fold_begindoc || l =~ s:fold_docclass
        return '1>'
    elseif l =~ s:fold_enddoc
        return '1'
    endif

    for fold in s:folds
        let depth = index(b:folds, fold)
        if nl =~ s:space . fold
            return '<' . depth
        elseif l =~ s:space . fold
            return depth . '>'
        endif
    endfor

    if l =~ s:fold_beginblock
        return 'a1'
    elseif l =~ s:fold_endblock
        return 's1'
    endif

    return '='
endfunction
