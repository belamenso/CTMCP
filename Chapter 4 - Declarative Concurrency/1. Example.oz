declare
fun {Gen L H}
   {Delay 100}
   if L>H then nil else L|{Gen L+1 H} end
end

% sequential
Xs={Gen 1 10}
Ys={Map Xs fun {$ X} X*X end}
{Browse Ys}

% concurrent declarative
declare Xs Ys in
thread Xs={Gen 1 30} end
thread Ys={Map Xs fun {$ X} X*X end} end
{Browse Ys}

%

local B in
   thread B = true end
   if B then {Browse done} end
end
