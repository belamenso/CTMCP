declare
proc {NewWrapper ?Wrap ?Unwrap}
   Key={NewName}
in
   fun {Wrap X}
      fun {$ K} if K==Key then X end end
   end
   fun {Unwrap W} {W Key} end
end

local Wrap Unwrap in
   {NewWrapper Wrap Unwrap} % Wrap and Unwrap are the only means to get to the stack representation and they are here lexically local
   fun {NewStack} {Wrap nil} end % we wrap outgoing values and unwrap incoming ones
   fun {Push S E} {Wrap E|{Unwrap S}} end
   fun {Pop S E}
      case {Unwrap S} of X|S1 then E=X {Wrap S1} end
   end
   fun {IsEmpty S} {Unwrap S}==nil end
end
