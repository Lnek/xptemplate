XPTemplate priority=lang mark=`~

let [s:f, s:v] = XPTcontainer() 
 
XPTvar $TRUE          1
XPTvar $FALSE         0
XPTvar $NULL          NULL
XPTvar $UNDEFINED     NULL
XPTvar $INDENT_HELPER /* void */;
XPTvar $IF_BRACKET_STL \n

XPTinclude 
      \ _common/common


" ========================= Function and Variables =============================


" ================================= Snippets ===================================
XPTemplateDef 


XPT str_ hint="SEL"
"`wrapped~"

XPT cmt_ hint={-\ SEL\ -}
{-
`wrapped~
-}

XPT p_ hint=(\ SEL\ )
(`wrapped~)

