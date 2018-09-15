declare

local
   fun {NotLoop Xs}
      case Xs of X|Xr then (1-X)|{NotLoop Xr} end
   end
in
   fun {NotG Xs} thread {NotLoop Xs} end end
end

fun {GateMaker F}
   fun {$ Xs Ys}
      fun {GateLoop Xs Ys}
	 case Xs#Ys of (X|Xr)#(Y|Yr) then
	    {F X Y}|{GateLoop Xr Ys}
	 end
      end
   in
      thread {GateLoop Xs Ys} end
   end
end

AndG={GateMaker fun {$ X Y} X*Y end}
OrG={GateMaker fun {$ X Y} X+Y-X*Y end}
NandG={GateMaker fun {$ X Y} 1-X*Y end}
NorG={GateMaker fun {$ X Y} 1-X-Y+X*Y end}
XorG={GateMaker fun {$ X Y} X+Y-2*X*Y end}

proc {FullAdder X Y Z ?C ?S}
   K L M
in
   K={AndG X Y}
   L={AndG Y Z}
   M={AndG X Z}
   C={OrG K {OrG L M}}
   S={XorG Z {XorG X Y}}
end

local
   X=1|1|0|_
   Y=0|1|0|_
   Z=1|1|1|_
   C S in
   {FullAdder X Y Z C S}
   {Browse inp(X Y Z)#sum(C S)}
end
