let s:header = '^[A-Z\s]\+'

function foldexpr#man#fold()
    let l = getline(v:lnum)
    let nl = getline(v:lnum + 1)

    if l =~ s:header
        return 'a1'
    endif

    if nl =~ s:header
        return 's1'
    endif

    return '='
endfunction
