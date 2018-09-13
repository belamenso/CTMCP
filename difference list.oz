declare
fun {AppendD D1 D2}
   S1 # E1 = D1
   S2 # E2 = D2
in
   E1 = S2
   S1 # E2
end

local X Y Z in
   {Browse {AppendD {AppendD (1|2|X)#X (a|b|Y)#Y} (9|9|9|Z)#Z}}
end

declare
fun {Flatten Xs}
   case Xs
   of nil then nil
   [] X|Xs  andthen {IsList X} then
      {Append {Flatten X} {Flatten Xs}}
   [] X|Xs then X|{Flatten Xs}
   end
end

{Browse {Flatten [[[1[[2] 3 4 [[[5 6 ] 7 ] 8] ]]] 9]}}

% flatten 1

declare
fun {Flatten Xs}
   proc {FlattenD Xs ?Ds}
      case Xs
      of nil then Y in Ds=Y#Y
      [] X|Xr andthen {IsList X} then Y1 Y2 Y4 in
	 Ds=Y1#Y4
	 {FlattenD X Y1#Y2}
	 {FlattenD Xr Y2#Y4}
      [] X|Xr then Y1 Y2 in
	 Ds=(X|Xr)#Y2
	 {FlattenD Xr Y1#Y2}
      end
   end Ys in
   {FlattenD Xs Ys#nil}
   Ys
end

% flatten 2

declare
fun {Flatten Xs}
   proc {FlattenD Xs ?S E}
      case Xs
      of nil then S=E
      [] X|Xr andthen {IsList X} then Y2 in
	 {FlattenD X S {FlattenD Xr $ E}}
      [] X|Xr then Y1 in
	 S=X|{FlattenD Xr $ E}
      end
   end
in {FlattenD Xs $ nil} end

{Browse {Flatten [[1] 2 3 [[[[[[4]]] 5]]] 6] }}

% flatten 3
declare
fun {Flatten Xs}
   fun {FlattenD Xs E}
      case Xs
      of nil then E
      [] X|Xr andthen {IsList X} then
	 {FlattenD X {FlattenD Xr E}}
      [] X|Xr then
	 X|{FlattenD Xr E}
      end
   end
in {FlattenD Xs nil} end

% list reversal (iterative + difference lists)

declare
fun {Reverse Xs}
   proc {ReverseD Xs ?Y1 Y}
      case Xs
      of nil then Y1=Y
      [] X|Xr then {ReverseD Xr Y1 X|Y}
      end
   end
in {ReverseD Xs $ nil} end

{Browse {Reverse [1 2 3 4 5 6 7 8 9 0]}}