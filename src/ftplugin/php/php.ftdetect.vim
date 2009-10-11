if exists("g:__PHP_FTDETECT_VIM__")
    finish
endif
let g:__PHP_FTDETECT_VIM__ = 1


if &filetype !~ 'php'
    finish
endif



let s:skipPattern = 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string\|comment"'
let s:pattern = {
            \   'php'    : {
            \       'start' : '\V\c<?\%(php\>\)\?',
            \       'mid'   : '',
            \       'end'   : '\V\c?>',
            \       'skip'  : s:skipPattern,
            \   },
            \   'javascript'    : {
            \       'start' : '\V\c<script\_[^>]\*>',
            \       'mid'   : '',
            \       'end'   : '\V\c</script>',
            \       'skip'  : s:skipPattern,
            \   },
            \   'css'           : {
            \       'start' : '\V\c<style\_[^>]\*>',
            \       'mid'   : '',
            \       'end'   : '\V\c</style>',
            \       'skip'  : s:skipPattern, 
            \   },
            \}

if exists( 'php_noShortTags' )
    let s:pattern.php.start = '\V\c<?php\>'
endif

let s:topFT = 'html'

fun! b:XPTfiletypeDetect() "{{{
    let pos = [ line( "." ), col( "." ) ]

    if pos == [1, 1]
        " for sheang(#!/usr/bin/php), it should be php. 
        return 'php'
    endif

    let synName = g:xptutil.XPTgetCurrentOrPreviousSynName()

    if synName == ''
        " top level ft is html 
        return s:topFT

    else

        for [ name, ftPattern ] in items( s:pattern )
            let pos = searchpairpos( ftPattern.start, ftPattern.mid, ftPattern.end, 'nbW', ftPattern.skip )
            if pos != [0, 0]
                return name
            endif
        endfor

        if synName =~ '^\cjavascript'
            return 'javascript'
        elseif synName =~ '^\ccss'
            return 'css'
        endif

        return s:topFT

    endif

endfunction "}}}



