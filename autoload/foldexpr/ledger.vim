let s:onefold = '\v^(payee|commodity|tag|\~ (Monthly|Quarterly|Yearly))'
let s:date = '[0-9\/\-]{10}'
let s:entryhead = '\v^' . s:date . '(\=' . s:date .')?\s(\*|\!)'

function! s:foldlevel(delta)
    return len(split(getline(v:lnum + a:delta), ":"))
endfunction

function! foldexpr#ledger#fold()
    let l = getline(v:lnum)
    let lfold = s:foldlevel(0)
    let nl = getline(v:lnum + 1)
    let nlfold = s:foldlevel(1)

    if l =~ '^account'
        return lfold . '>'
    endif

    if nl =~ '^account'
        return '<' . nlfold
    endif

    if l =~ s:onefold || l =~ s:entryhead
        return '1>'
    elseif nl =~ s:onefold || nl =~ s:entryhead
        return '<1'
    endif

    return '='
endfunction
