" XPTemplate priority=lang keyword=# mark=12 indent=auto
XPTemplate priority=lang keyword=# indent=auto


XPTvar $TRUE          1
XPTvar $FALSE         0
XPTvar $NULL          NULL
XPTvar $IF_BRACKET_STL  \ 
XPTvar $INDENT_HELPER /* void */;


XPTinclude
      \ _common/common 
      \ _comment/c.like 
      \ _condition/c.like
      \ _loops/c.like
      \ _structures/c.like
      \ _preprocessor/c.like


" ========================= Function and Varaibles =============================

let s:f = XPTcontainer()[ 0 ]

function! s:f.showList()
   return [ "xx-small", "x-small", "small", "medium", "large", "x-large", "xx-large", "larger", "smaller" ]
endfunction

" draft implementation 
fun! s:f.c_patternItem( v )
  let v = a:v
  if v =~ '\V%'
    let len = len( substitute( v, '\V\[^%]', '', 'g' ) )
    let re = ''
    while len > 0
      let len -= 1

      let re .= ', `i' . len . '^'

    endwhile
    return re
  else 
    return ''
  endif
endfunction

" ================================= Snippets ===================================
XPTemplateDef

" for (`-`i`-^ = `0^; `i^ < `len^; ++`i^)`$IF_BRACKET_STL^{
XPT for hint=for\ (..;..;++)
for (`-`i`-^ = `0^; `i^UpperCase(V())^ < `len^; ++`i^UpperCase('_'.V())^^)`$IF_BRACKET_STL^{
    `test^\`what\^..\`\`what\^^^
    `cursor^
}
..XPT


XPT printf	hint=printf\\(...)
XSET elts=c_patternItem( R( 'pattern' ) )
printf( "`pattern^"`elts^ );
..XPT


"  XSET p..|post=ExpandIfNotEmpty(', ', 'p..')
XPT fsa hint=$author\ what\ {$author} --
XSET size=showList()
 `p..^ExpandIfNotEmpty(', ', 'p..')^^
..XPT
"  --font-size: `--`size`==^
" " `size^
" 
" XPT Fsa
" bbb
" ..XPT
" XPT fsad
" ccc
" ..XPT
" XPT Fsae
" ddd
" ..XPT
" 
" XPT tt
" XSET to=Trigger("fs")
" "`~~~`to`***^"
" ..XPT
" 
" XPT yy
" `-`w`=^~NN()~^
" ..XPT


" " sample:
" XPT for indent=/2*8 hint=this\ is\ for
" for (`i^ = 0; `i^ < `len^; ++`i^) {
"   `cursor^
" }


" " JUST A TEST
" "
" " Super Repetition. saves 1 key pressing. without needing expanding repetition
" " For small repetition usage. Such as parameter list
" " 
" "   type first, then <tab>
" " NOT <tab> then type
" "
" " NOTE that "exp" followed by only 2 dot. distinction from normal
" " expandable. For normal expandable does not evaluate expression.
" "
" XPT superrepetition
" XSET exp..|post=ExpandIfNotEmpty(', ', 'exp..')
" `exp..^




XPT assert	hint=assert\ (..,\ msg)
assert(`isTrue^, "`text^");

XPT main hint=main\ (argc,\ argv)
  int
main(int argc, char **argv)
{
  `cursor^
  return 0;
}

" Quick-Repetition parameters list
XPT fun		hint=func..\ (\ ..\ )\ {...
XSET p..|post=ExpandIfNotEmpty(', ', 'p..')
  `int^
`name^(`p..^)
{
  `cursor^
}

XPT cmt
/**
 * @author : `$author^ | `$email^
 * @description
 *     `cursor^
 * @return {`int^} `desc^
 */


XPT para syn=comment	hint=comment\ parameter
@param {`Object^} `name^ `desc^


XPT filehead
/**-------------------------/// `sum^ \\\---------------------------
 *
 * <b>`function^</b>
 * @version : `1.0^
 * @since : `strftime("%Y %b %d")^
 * 
 * @description :
 *   `cursor^
 * @usage : 
 * 
 * @author : `$author^ | `$email^
 * @copyright `.com.cn^ 
 * @TODO : 
 * 
 *--------------------------\\\ `sum^ ///---------------------------*/

