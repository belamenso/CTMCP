
% first version

declare Sqrt SqrtIter Improve GoodEnough Abs
fun {Sqrt X}
   Guess=1.0
in
   {SqrtIter Guess X}
end
fun {SqrtIter Guess X}
   if {GoodEnough Guess X} then Guess
   else
      {SqrtIter {Improve Guess X} X}
   end
end
fun {Improve Guess X}
   (Guess + X/Guess) / 2.0
end
fun {GoodEnough Guess X}
   {Abs X-Guess*Guess}/X < 0.00001
end
fun {Abs X} if X<0.0 then ~X else X end end

% optimal version

declare Sqrt
fun {Sqrt X}
   fun {Improve Guess}
      (Guess + X/Guess) / 2.0
   end
   fun {GoodEnough Guess}
      {Abs X-Guess*Guess}/X < 0.00001
   end
   fun {SqrtIter Guess}
      if {GoodEnough Guess} then Guess
      else {SqrtIter {Improve Guess}} end
   end
   Guess = 1.0
in
   {SqrtIter Guess}
end

{Browse {Sqrt 2.}}

% general iteration schema

declare Iterate Sqrt
fun {Iterate S IsDone Transform}
   if {IsDone S} then S
   else S1 in
      S1 = {Transform S}
      {Iterate S1 IsDone Transform}
   end
end

fun {Sqrt X}
   {Iterate
    1.0
    fun {$ G} {Abs X-G*G}/X < 0.00001 end
    fun {$ G} (G+X/G)/2.0 end}
end
