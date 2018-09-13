declare
fun {Lookup X T}
   case T
   of leaf then notfound
   [] tree(Y V T1 T2) then
      if X < Y then {Lookup X T1}
      elseif X > Y then {Lookup X T2}
      else found(V) end
   end
end

fun {Insert X V T}
   case T
   of leaf then tree(X V leaf leaf)
   [] tree(Y V T1 T2) andthen X==Y then found(V)
   [] tree(Y V T1 T2) andthen X<Y then tree(Y V {Insert X V T1} T2)
   [] tree(Y V T1 T2) andthen X>Y then tree(Y V T1 {Insert X V T2})
   end
end

fun {Delete X T}
   case T
   of leaf then leaf
   [] tree(Y W T1 T2) andthen X==Y then
      case {RemoveSmallest T2}
      of none then T1
      [] Yp#Vp#Tp then tree(Yp Vp T1 Tp)
      end
   [] tree(Y W T1 T2) andthen X < Y then tree(Y W {Delete X T1} T2)
   [] tree(Y W T1 T2) andthen X < Y then tree(Y W T1 {Delete X T2})
   end
end

fun {RemoveSmallest T}
   case T
   of leaf then none
   [] tree(Y V T1 T2) then
      case {RemoveSmallest T1}
      of none then Y#V#T2
      [] Yp#Vp#Tp then Yp#Vp#tree(Y V Tp T2)
      end
   end
end
      
declare
proc {DFS T}
   case T
   of leaf then skip
   [] tree(Key Val L R) then
      {Browse Key#Val}
      {DFS L}
      {DFS R}
   end
end

proc {DFSAccLoop T S1 ?Sn}
   case T
   of leaf then Sn=S1
   [] tree(Key Val L R) then S2 S3 in
      S2=Key#Val|S1
      {DFSAccLoop L S2 S3}
      {DFSAccLoop R S3 Sn}
   end
end
fun {DFSAcc T} {Reverse {DFSAccLoop T nil $}} end

proc {DFSAccLoop2 T ?S1 Sn}
   case T
   of leaf then S1=Sn
   [] tree(Key Val L R) then S2 S3 in
      S1=Key#Val|S2
      {DFSAccLoop2 L S2 S3}
      {DFSAccLoop2 R S3 Sn}
   end
end
fun {DFSAcc2 T} {DFSAccLoop2 T $ nil} end

% graphical tree display
declare
Scale=30
proc {DepthFirst Tree Level LeftLim ?RootX ?RightLim}
   case Tree
   of tree(x:X y:Y left:leaf right:leaf ...) then
      X=RootX=RightLim=LeftLim
      Y=Scale*Level
   [] tree(x:X y:Y left:L right:leaf ...) then
      X=RootX
      Y=Scale*Level
      {DepthFirst L Level+1 LeftLim RootX RightLim}
   [] tree(x:X y:Y left:leaf right:R ...) then
      X=RootX
      Y=Scale*Level
      {DepthFirst R Level+1 LeftLim RootX RightLim}
   [] tree(x:X y:Y left:L right:R ...) then
      LRootX LRightLim RRootX RLeftLim
   in
      Y=Scale*Level
      {DepthFirst L Level+1 LeftLim LRootX LRightLim}
      RLeftLim=LRightLim+Scale
      {DepthFirst R Level+1 RLeftLim RRootX RightLim}
      X=RootX=(LRootX+RRootX) div 2
   end
end

declare
fun {AddXY Tree}
   case Tree
   of tree(left:L right:R ...) then
      {Adjoin Tree
       tree(x:_ y:_ left:{AddXY L} right:{AddXY R})}
   [] leaf then
      leaf
   end
end

local X Y in
   {DepthFirst {AddXY tree(left:tree(left:leaf right:leaf) right:leaf)} 1 Scale X Y}
   {Browse X}
   {Browse Y}
end
