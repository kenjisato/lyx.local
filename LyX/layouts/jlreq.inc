# jlreq.inc
# Basic layout definition file for jlreq class. 


ModifyStyle Section
    Argument post:1
		LabelString   "副題"
		Tooltip       "Subtitle"
        LeftDelim     "["
        RightDelim    "]"
        Font
            Size    Small
        EndFont
	EndArgument
    Font
	  Series              Bold
      Family              Sans
	  Size                Larger
	EndFont
End


ModifyStyle Section*
    Argument post:1
		LabelString   "副題"
		Tooltip       "Subtitle"
        LeftDelim     "["
        RightDelim    "]"
        Font
            Size    Small
        EndFont
	EndArgument
    Font
	  Series              Bold
      Family              Sans
	  Size                Larger
	EndFont
End


ModifyStyle Subsection
    Argument post:1
		LabelString   "副題"
		Tooltip       "Subtitle"
        LeftDelim     "["
        RightDelim    "]"
        Font
            Size    Small
        EndFont
	EndArgument
    Font
	  Series              Bold
      Family              Sans
	  Size                Large
	EndFont
End

ModifyStyle Subsection*
    Argument post:1
		LabelString   "副題"
		Tooltip       "Subtitle"
        LeftDelim     "["
        RightDelim    "]"
        Font
            Size    Small
        EndFont
	EndArgument
    Font
	  Series              Bold
      Family              Sans
	  Size                Large
	EndFont
End


ModifyStyle Subsubsection
    Argument post:1
		LabelString   "副題"
		Tooltip       "Subtitle"
        LeftDelim     "["
        RightDelim    "]"
        Font
            Size    Small
        EndFont
	EndArgument
    Font
      Family              Sans
	EndFont
End

ModifyStyle Subsubsection*
    Argument post:1
		LabelString   "副題"
		Tooltip       "Subtitle"
        LeftDelim     "["
        RightDelim    "]"
        Font
            Size    Small
        EndFont
	EndArgument
    Font
      Family              Sans
	EndFont
End


InsetLayout  "Flex:JL/sidenote"
    LyXType     custom
    Decoration  classic
    LabelString sidenote
    LatexName   sidenote
    LatexType   command
    MultiPar        false
    ContentAsLabel  true
    Argument post:1
      LabelString     "項目"
      AutoInsert      1
      Mandatory       1
    EndArgument
    EndArgument
    LabelFont
      Color               marginlabel
    EndFont
End

InsetLayout  "Flex:JL/sidenote"
    LyXType     custom
    Decoration  classic
    LabelString sidenote
    LatexName   sidenote
    LatexType   command
    MultiPar        false
    ContentAsLabel  true
    LabelFont
      Color               marginlabel
    EndFont
End