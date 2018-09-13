declare
fun {Fact N}
   if N==0 then 1
   elseif N > 0 then N*{Fact N-1}
   else raise domainError end
   end
end

declare
fun {Fact N}
   fun {FactIter N A}
      if N == 0 then A
      elseif N>0 then {FactIter N-1 A*N}
      else raise domainError end
      end
   end
in
   {FactIter N 1}
end

{Browse {Fact 10}}

declare
fun {Len Ls}
   case Ls
   of nil then 0
   [] _|Lr then 1+{Len Lr}
   end
end

{Browse {Len [1 2 3 4 5]}}

declare
fun {Nth Xs N}
   if N == 1 then Xs.1
   elseif N > 1 then {Nth Xs.2 N-1}
   end
end

{Browse {Nth 1|2|3|nil 1}}

declare
fun {NaiveReverse Xs}
   case Xs
   of nil then nil
   [] X|Xr then {Append {NaiveReverse Xr} [X]}
   end
end

declare
fun {Reverse Xs}
   fun {Iter Xs A}
      case Xs
      of nil then A
      [] X|Xr then {Iter Xr X|A}
      end
   end
in
   {Iter Xs nil}
end

{Browse{Reverse [1 2 3 4 5]}}

declare
fun {Len Xs}
   fun {Iter Xs Count}
      case Xs
      of nil then Count
      [] _|Xr then {Iter Xr Count+1}
      end
   end
in
   {Iter Xs 0}
end

{Browse {Len [1 2 3 4 5 6 7]}}

declare
fun {NestedListLen NL}
   case NL
   of nil then 0
   [] X|Xr andthen {IsList X} then {NestedListLen X} + {NestedListLen Xr}
   [] X|Xr then 1 + {NestedListLen Xr}
   end
end

{Browse {NestedListLen [[1 2 3] [4] 5 [6 7 8 [[[[[9]]]]]]]}}
local X = [[1 2] 4 nil [[5] 10]] in
   {Browse {NestedListLen X}}
   {Browse {NestedListLen [X X]}}
end
