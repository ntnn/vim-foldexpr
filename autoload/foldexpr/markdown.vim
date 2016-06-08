" vim-foldexpr
" Maintainer:	ntnn <nelo@wallus.de>
" Version:	1
" License:	MIT
" Website:	https://github.com/ntnn/vim-foldexpr

function s:header_level(string) abort
    " Returns the header level a given string would have
    return strchars(matchstr(a:string, '\v^#+'))
    "      |        |                   +- 'match all leading pounds'
    "      |        + returns the matched part of a given string
    "      + count the number of characters in given string
endfunction

function foldexpr#markdown#fold()
    let l:curline = getline(v:lnum)
    let l:last_foldlevel = foldlevel(line('.') - 1)

    if l:curline =~ '^```'
        " if current line matches the start or the end of a fenced code
        " block check if b:fenced is set
        if get(b:, 'fenced', 0)
            " fenced is 1, fenced block ends here, set b:fenced to 0 and
            " substract level
            let b:fenced = 0
            return 's1'
        else
            " fenced is unset or 0, fenced block starts here, et
            " b:fenced to 1 and add level
            let b:fenced = 1
            return 'a1'
        endif
    endif

    if get(b:, 'fenced', 0)
        " inside of fenced code block, no folding
        return '='
    endif

    let l:curline_headerlevel = s:header_level(l:curline)
    if l:curline_headerlevel != 0
        " if the current line has a headerlevel return that as starting
        " indent level
        return '>' . l:curline_headerlevel
    endif

    " line is not a header or (in) a fenced code block
    " check for header on the next line
    let l:nextline = getline(v:lnum + 1)
    if l:nextline =~ '\v^#'
        let l:nextline_headerlevel = markdown#Headerlevel(l:nextline)
        if l:last_foldlevel < l:nextline_headerlevel
            " next line is a deeper header, keep last level
            return '='
        else
            " next line is a header with a smaller or equal depth, substract level
            return '<' . l:last_foldlevel
        endif
    endif

    " all other lines don't do anything to the fold
    return '='
endfunction
