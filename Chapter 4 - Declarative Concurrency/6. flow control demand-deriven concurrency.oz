declare
proc {DGenerate N Xs}
   case Xs of X|Xr then
      X=N
      {DGenerate N+1 Xr}
   end
end
fun {DSum ?Xs A Limit}
   if Limit > 0 then
      X|Xr=Xs
   in
      {DSum Xr A+X Limit-1}
   else A end
end
local Xs S in
   thread {DGenerate 0 Xs} end
   thread S={DSum Xs 0 150000} end
   {Browse S}
end
