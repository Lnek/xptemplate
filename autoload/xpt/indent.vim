exec xpt#once#init

let s:oldcpo = &cpo
set cpo-=< cpo+=B

let s:log = xpt#debug#Logger( 'warn' )

exe XPT#importConst


" Converting indent to real space-chars( like spaces or tabs ) must be done at
" runtime.
" Here we only convert it to tabs, to ease further usage.
let s:indent_convert_cmd = 'substitute(v:val, ''\v(^\s*)@<=    '', ''	'', "g" )'

fun! xpt#indent#ParseStr( text, first_line_shift ) "{{{
    let text = xpt#indent#IndentToTabStr(a:text)
    return xpt#indent#ToActualIndentStr(text, a:first_line_shift)
endfunction "}}}

fun! xpt#indent#IndentToTabStr( text ) "{{{
    let lines = split( a:text, '\n', 1 )
    call xpt#indent#IndentToTab( lines )
    return join(lines, "\n")
endfunction "}}}

fun! xpt#indent#ToActualIndentStr( text, first_line_shift ) "{{{
    let lines = split( a:text, '\n', 1 )
    call xpt#indent#ToActualIndent( lines, a:first_line_shift )
    return join(lines, "\n")
endfunction "}}}

fun! xpt#indent#IndentToTab( lines ) "{{{
    call map( a:lines, s:indent_convert_cmd )
endfunction "}}}

fun! xpt#indent#ToActualIndent( lines, first_line_shift ) "{{{
    " Convert tab indent to actual indent according to vim setting
    " 'shiftwidth' that defines width in char for each indent, and 'tabstop'
    " that defines number of spaces a <tab> counts for.

    let indent_spaces = repeat(' ', &shiftwidth)
    let cmd = 'substitute(v:val, ''\v(^	*)@<=	'', ''' . indent_spaces . ''', "g" )'
    call map( a:lines, cmd )

    if a:first_line_shift != 0
        let shift_spaces = repeat(' ', a:first_line_shift)
        let i = 1
        while i < len(a:lines)
            let a:lines[i] = shift_spaces . a:lines[i]
            let i += 1
        endwhile
    endif

    if &expandtab
        return
    endif

    let tabspaces = repeat( ' ',  &tabstop )
    let cmd = 'substitute(v:val, ''\v(^\s*)@<=' . tabspaces . ''', ''	'', "g" )'
    call map( a:lines, cmd )

endfunction "}}}

let &cpo = s:oldcpo
