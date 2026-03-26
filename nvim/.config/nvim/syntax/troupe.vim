if exists("b:current_syntax")
  finish
endif

" Literals and Constants
syntax region troupeString start='"' end='"' skip='\\"'
syntax match troupeNumber "\<\d\+\>"
syntax keyword troupeBoolean true false
syntax match troupeWildcard "\<_\>"

" Keywords 
syntax keyword troupeKeyword let in end val fun case of import module 
syntax keyword troupeKeyword if then else and pini when

" IFC & Actor Primitives 
syntax keyword troupeActor spawn self send receive register node whereis rcv rcvp
syntax keyword troupeActor declassify attenuate raisembox lowermbox sandbox raiseTrust
syntax keyword troupeActor _setProcessDebuggingName exit sleep print printWithLabels
syntax keyword troupeActor getTime inputLine mkuuid random debugpc

" Types
syntax keyword troupeType authority label

" Functions 
syntax match troupeFunction "\v(fun|and)\s+\zs\w+"

" Operators
syntax keyword troupeOperator andalso orelse raisedTo
syntax match troupeOperator "=>"
syntax match troupeOperator "->"
syntax match troupeOperator "::"
syntax match troupeOperator "[:=+\-\*\/<>^]"

" Delimiters
syntax match troupeDelimiter "[)\[\],.;]"
syntax match troupeDelimiter "(\ze[^*]"
syntax match troupeDelimiter "[^*]\zs)"

" Comments
syntax region troupeComment start="(\*" end="\*)" contains=troupeComment

" Highlighting Links
highlight default link troupeKeyword   Statement
highlight default link troupeActor     Function
highlight default link troupeType      Type
highlight default link troupeComment   Comment
highlight default link troupeString    String
highlight default link troupeNumber    Constant
highlight default link troupeBoolean   Constant
highlight default link troupeWildcard  Special
highlight default link troupeOperator  Operator
highlight default link troupeDelimiter Delimiter
highlight default link troupeFunction  Identifier

let b:current_syntax = "troupe"
