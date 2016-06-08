" vim-foldexpr
" Maintainer:	ntnn <nelo@wallus.de>
" Version:	1
" License:	MIT
" Website:	https://github.com/ntnn/vim-foldexpr

let s:function = 'fu(n(ction)?)?'
let s:augroup = 'aug(roup)?'
let s:space = '\v^\s*'

let s:blockstart = printf('%s(if|for|while|%s|%s)', s:space, s:function, s:augroup)
let s:blockend = printf('%s(end(if|for|while|%s)|%s\sEND)', s:space, s:function, s:augroup)

let s:openbraces = '\v(\(|\{|\[)$'
let s:closebraces = s:space . '\\\s+(\)|\}|\])'

function foldexpr#vim#fold()
    let pl = getline(v:lnum - 1)
    let l = getline(v:lnum)
    let nl = getline(v:lnum + 1)

    " markers
    if l =~ '{{{'
        return 'a1'
    endif
    if l =~ '}}}'
        return 's1'
    endif

    if l =~ s:blockstart || l =~ s:openbraces
        return 'a1'
    endif

    if l =~ s:blockend || l =~ s:closebraces
        return 's1'
    endif

    return '='
endfunction
