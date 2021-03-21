# bxjsclass definition file.
# Definitions for styles specific to the bxjs* classes.
# Kenji Sato <mail@kenjisato.jp>

Format 66

Style Subtitle
	CopyStyle             Title
	LatexName             subtitle
	Font
	  Size                Large
	EndFont
End


Style Abstract
	Category              MainText
	Margin                Static
	LatexType             Environment
	LatexName             abstract
	ToggleIndent          Always
	LeftMargin            MMM
	RightMargin           MMM
	ParIndent             MM
	ToggleIndent          Always
	ParSkip               0.5
	ParSep                0.5
	Align                 Block
	AlignPossible         Block, Left, Right, Center
End

Style Strongenv
	Category              MainText
	Margin                Static
	LatexType             Environment
	LatexName             strongenv
	NextNoIndent          1
	ToggleIndent          Always
	ParbreakIsNewline			1
	ParSkip               0
	ParSep                0
	Align                 Block
	AlignPossible         Block, Left, Right, Center
	Font
		Series              Bold
		Family							Sans
		Size                Normal
	EndFont
End

InsetLayout  "Flex:Strong"
    LyXType     charstyle
    LabelString Strong
    LatexName   strong
    LatexType   command
    MultiPar        false
    ContentAsLabel  false
    Font
	      Series			Bold
				Family			Sans
				Size				Normal
    EndFont
		HTMLTag					strong
End
