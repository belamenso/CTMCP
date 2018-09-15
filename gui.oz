declare [Qtk]={Module.link ['x-oz://system/wp/QTk.ozf']}

declare In Out
A1=proc {$} X in {In get(X)} {Out set(X)} end
A2=proc {$} {W close} end
D=td(title:"Simple text I/O interface"
     lr(label(text:"Input:")
	text(handle:In tdscrollbar:true glue:nswe)
	glue:nswe)
      lr(label(text:"Output:")
	text(handle:Out tdscrollbar:true glue:nswe)
	 glue:nswe)
     lr(button(text:"Do It" action:A1 glue:nswe)
	button(text:"Quit" action:A2 glue:nswe)
	glue:we))
W={Qtk.build D}
{W show}

declare
D=td(button(text:"Press me" action:proc {$} {Browse ouch} end))
W={Qtk.build D}
{W show}