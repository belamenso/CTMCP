declare X = proc {$ K} (K + 10) end

{Browse (Map (proc {$ K} K + 20 end) [1 2 3 4 54])}

local `hello there ałajć` in
   `hello there ałajć` = 1012
   {Browse `hello there ałajć`}
end

declare proc {MyMax A B ?Z}
	   if A >= B then Z = A else Z = B end
	end

local X in
   X = {MyMax 1 20}
   {Browse X}
end

{Browse {Map [1 2 3 4 5 6] fun {$ X} X*X end}}

local H|T = [1 2 3 4 5] in {Browse H} {Browse T} end
declare X
{Browse X}

declare A B C in C=A+B {Browse C}

A = 100

B = 200

local X=0 in {Browse start} {Browse 10 div X} {Browse 'end'} end

fun {Eval E}
   if {IsNumber E} then E
   else
      case E
      of plus(X Y) then {Eval X} + {Eval Y}
      [] times(X Y) then {Eval X} * {Eval Y}
      else raise illFormedExpr(E) end
      end
   end
end
