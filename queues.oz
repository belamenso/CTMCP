declare
proc {ButLast L ?X ?L1}
   case L
   of [Y] then X=Y L1=nil
   [] Y|L2 then L3 in
      L1=Y|L3
      {ButLast L2 X L3}
   end
end

% amortized constant-time ephemeral queue

declare
fun {NewQueue} q(nil nil) end
fun {Check Q}
   case Q
   of q(nil R) then q({Reverse R} nil)
   else Q end
end
fun {Insert Q X}
   case Q of q(F R) then {Check q(F X|R)} end
end
fun {Delete Q X}
   case Q of q(F R) then F1 in F=X|F1 {Check q(F1 R)} end
end
fun {IsEmpty Q}
   case Q of q(F R) then F == nil end
end

local X in {Browse [1 2 3 4 X]#[3 4 X]} end

% dataflow worst-case constant time

declare
fun {NewQueue} X in q(0 X X) end
fun {Insert Q X}
   case Q of q(N S E) then E1 in E=X|E1 q(N+1 S E1) end
end
fun {Delete Q X}
   case Q of q(N S E) then S1 in S=X|S1 q(N-1 S1 E) end
end
fun {IsEmpty Q}
   case Q of q(N S E) then N==0 end
end

% tests

declare Q1 Q2 Q3 Q4 Q5 Q6 Q7 in
Q1 = {NewQueue}
Q2 = {Insert Q1 peter}
Q3 = {Insert Q2 paul}
local X in Q5={Delete Q3 X} {Browse X} end
local X in Q6={Delete Q5 X} {Browse X} end

% forking queues

declare
proc {ForkD D ?E ?F}
   D1#nil=D
   E1#E0=E {Append D1 E0 E1}
   F1#F0=F {Append D1 F0 F1}
in skip end

proc {ForkQ Q ?Q1 ?Q2}
   q(N S E)=Q
   q(N S1 E1)=Q1
   q(N S2 E2)=Q2
in
   {ForkD S#E S1#E1 S2#E2}
end
