declare
fun {NewStack} nil end
fun {Push S E} E|S end
fun {Pop S E} case S of X|S1 then E=X S1 end end
fun {IsEmpty S} case S of nil then true else false end end

declare
fun {NewStack} stackEmpty end
fun {Push S E} stack(E S) end
fun {Pop S E} case S of stack(X S1) then E=X S1 end end
fun {IsEmpty S} S==stackEmpty end

local X X1 X2 in
   X = {NewStack}
   X1 = {Push X hello}
   X2 = {Push X1 world}
   {Browse {Pop X2 $ _}}
end
