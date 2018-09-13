declare
fun {Fact N}
   if N == 0 then 1 else N*{Fact N-1} end
end

declare L = [5 6 7 8 9]

case L of H|T then
   {Browse H}
   {Browse T}
end

declare Pascal AddList ShiftLeft ShiftRight
fun {Pascal N}
   if N == 1 then [1]
   else
      {AddList {ShiftLeft {Pascal N-1}} {ShiftRight {Pascal N-1}}}
   end
end

fun {ShiftLeft L}
   case L of H|T then
      H|{ShiftLeft T}
   else [0] end
end

fun {ShiftRight L} 0|L end

fun {AddList L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 H1+H2|{AddList T1 T2}
      end
   else nil end
end

declare
fun {FastPascal N}
   if N == 0 then [1]
   else L in
      L = {FastPascal N-1}
      {AddList {ShiftLeft L} {ShiftRight L}}
   end
end

{Browse {FastPascal 30}}

declare
fun lazy {Ints N} N|{Ints N+1} end

{Browse {Ints 0}.2.2.2.2.2.2.1}
case {Ints 0} of A|B|C|_ then {Browse [A B C]} end

declare
fun lazy {PascalList Row}
   Row|{PascalList
	{AddList {ShiftLeft Row} {ShiftRight Row}}}
end

declare
fun {PascalList2 N Row}
   if N == 1 then [Row]
   else
      Row|{PascalList2 N-1
	   {AddList {ShiftLeft Row} {ShiftRight Row}}}
   end
end

{Browse {PascalList2 10 [1]}}

declare OpList
fun {GenericPascal Op N}
   if N==1 then [1]
   else L in
      L = {GenericPascal Op N-1}
      {OpList Op {ShiftLeft L} {ShiftRight L}}
   end
end

fun {OpList Op L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 {Op H1 H2}|{OpList Op T1 T2}
      end
   else nil end
end

declare fun {Add X Y} X + Y end

declare fun {FastPascal2 N} {GenericPascal Add N} end
declare fun {Xor X Y} if Y == X then 0 else 1 end end

{Browse {GenericPascal Xor 6}}

thread P in
   P = {Pascal 20}
   {Browse P}
end
{Browse 99*99}

% dataflow behavior #1
declare Q in
thread {Delay 3000} Q = 99 end
{Browse start} {Browse Q*Q}

% dataflow behavior #2
declare Q in
thread {Browse start} {Browse Q*Q} end
{Delay 3000} Q = 99

% explicit state
declare
C = {NewCell 0}
C := @C+1
{Browse @C}

% objects
declare
local C in
   C = {NewCell 0}
   fun {Bump}
      C := @C + 1 @C
   end
   fun {Read}
      @C
   end
end

% classes
declare
fun {NewCounter}
   C Bump Read in
   C = {NewCell 0}
   fun {Bump}
      C := @C + 1
      @C
   end
   fun {Read} @C end
   counter(bump:Bump read:Read)
end

% race condition

declare C = {NewCell 0}
thread C := 3 end
thread C := 2 end
thread C := 10 end

{Browse @C}

% race condition #2

declare C = {NewCell 0}
thread I in
   I = @C
   C := I + 1
end
thread J in
   J = @C
   C := J + 1
end

{Browse @C}

{Browse [1 2 3 'sdfadsf' "dsafsfdsd"]}

local X Y Z in
   X = Y = Z = 10
   {Browse X}
end
