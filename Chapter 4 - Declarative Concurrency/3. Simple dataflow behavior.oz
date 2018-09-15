% 1
declare X0 X1 X2 X3 in
thread Y0 Y1 Y2 Y3 in
   {Browse [Y0 Y1 Y2 Y3]}
   Y0=X0+1
   Y1=X1+Y0
   Y2=X2+Y1
   Y3=X3+Y2
   {Browse completed}
end
{Browse [X0 X1 X2 X3]}

X0=1
X1=0
X2=3
X3=8

% 2
declare L in
thread {ForAll L Browse} end

declare L1 L2
thread L=1|L1 end
thread L1=2|3|L2 end
thread L2=4|nil end

% concurrent map
declare
fun {MyMap Xs F}
   case Xs
   of nil then nil
   [] X|Xr then thread {F X} end|{MyMap Xr F}
   end
end

declare Xs Ys F
F=fun {$ X} X*X end
Ys={Map Xs F}
declare X1 X2
{Browse Ys}
Xs=1|2|X1
X1=3|4|X2
X2=5|nil

% threaded Fibbonacci
declare
fun {Fib N}
   if N =< 2 then 1
   else thread {Fib N-1} end + {Fib N-1}
   end
end

{Browse {Fib 10}}

%

{Browse {Property.get priorities}}