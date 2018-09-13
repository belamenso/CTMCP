declare
fun {Merge Xs Ys}
   case Xs # Ys
   of nil # Ys then Ys
   [] Xs # nil then Xs
   [] (X|Xr) # (Y|Yr) then
      if X =< Y then X|{Merge Xr Ys}
      else Y|{Merge Xs Yr}
      end
   end
end

declare
proc {Split Xs ?Ys ?Zs}
   case Xs
   of nil then Ys=nil Zs=nil
   [] [X] then Ys=[X] Zs=nil
   [] X1|X2|Xr then Yr Zr in
      Ys = X1|Yr
      Zs = X2|Zr
      {Split Xr Yr Zr}
   end
end

declare
fun {MergeSort Xs}
   case Xs
   of nil then nil
   [] [X] then [X]
   else Ys Zs in
      {Split Xs Ys Zs}
      {Merge {MergeSort Ys} {MergeSort Zs}}
   end
end

local X = [1 2 4 1 5 1 5 2 34 5 61 22] in
   {Browse {MergeSort X}}
end

declare
fun {NMergeSort Xs}
   fun {MergeSortAcc L1 N}
      if N == 0 then nil # L1
      elseif N == 1 then [L1.1] # L1.2
      elseif N > 1 then
	 NL = N div 2
	 NR = N - NL
	 Ys # L2 = {MergeSortAcc L1 NL}
	 Zs # L3 = {MergeSortAcc L2 NR}
      in
	 {Merge Ys Zs} # L3
      end
   end
in
   {MergeSortAcc Xs {Length Xs}}.1
end
