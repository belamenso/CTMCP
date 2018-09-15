declare

fun {Generate L H}
   if L>H then nil
   else L|{Generate L+1 H}
   end
end

fun {Sieve Xs}
   case Xs
   of nil then nil
   [] X|Xr then Ys in
      thread Ys={Filter Xr fun {$ Y} Y mod X \= 0 end} end
      X|{Sieve Ys}
   end
end

local Xs Ys in
   thread Xs={Generate 2 1000000} end
   thread Ys={Sieve Xs} end
   {Browse Xs}
end

%

declare
fun {BetterSieve Xs M}
   case Xs
   of nil then nil
   [] X|Xr then Ys in
      if X=<M then
	 thread Ys={Filter Xr fun {$ Y} Y mod X \= 0 end} end
      else Ys=Xr end
   end
end

local Xs Ys in
   thread Xs={Generate 2 1000000} end
   thread Ys={Sieve Xs 316} end
   {Browse Xs}
end