" vim-foldexpr
" Maintainer:	ntnn <nelo@wallus.de>
" Version:	1
" License:	MIT
" Website:	https://github.com/ntnn/vim-foldexpr

let s:decorator = '^\s*@'
let s:docstring_oneline = '""".*"""$'
let s:docstring_start = '""".\+'
let s:docstring_end = '"""$'

function foldexpr#python#fold()
    let pl = getline(v:lnum - 1)
    let plind = indent(v:lnum - 1)
    let l = getline(v:lnum)
    let lind = indent(v:lnum)
    let nl = getline(v:lnum +  1)
    let nlind = indent(v:lnum + 1)

    " fold preamble
    if v:lnum == 1
        return '1>'
    endif

    if l !~ s:docstring_oneline
        if l =~ s:docstring_start
            return 'a1'
        elseif l =~ s:docstring_end
            return 's1'
        endif
    endif

    if l =~ s:decorator && pl !~ s:decorator
        return 'a1'
    endif

    " if, elif, else, def, class, ...
    if l =~ ':$' && pl !~ s:decorator
        return 'a1'
    endif


    if l =~ '^\s*$'
        " two consecutive empty lines
        if pl =~ '^\s*$' && nl !~ '^\s*$'
            return '<1'
        endif

        " space between two function
        if plind > nlind
            return 's1'
        endif
    endif

    return '='
endfunction

function foldexpr#python#text()
    let l = v:foldstart

    while getline(l) =~ s:decorator && l != v:foldend
        let l = l + 1
    endwhile

    if l == v:foldend
        let l = v:foldstart
    endif

    return getline(l)
endfunction
