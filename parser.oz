declare
fun {Stat S1 Sn}
   T|S2=S1 in
   case T
   of begin then
      {Sequence Stat fun {$ X} X=';' end S2 'end'|Sn} % begin { <Stat> ; } <Stat> end - we use Sequence to handle ;-separated sequence and end|Sn to assign on the spot

% things below are quite litera translation of the grammar
      
   [] 'if' then C X1 X2 S3 S4 S5 S6 in
      {Comp C S2 S3}
      S3='then'|S4
      X1={Stat S4 S5}
      S5='else'|S6
      X2={Stat S6 Sn}
      'if'(C X1 X2)
   [] while then C X S3 S4 in
      C={Comp S2 S3}
      S3='do'|S4
      X={Stat S4 Sn}
      while(C X)
   [] read then I in
      I={Id S2 Sn}
      read(I)
   [] write then E in
      E={Expr S2 Sn}
      write(E)
   elseif {IsIdent T} then E S3 in
      S2=':='|S3
      E={Expr S3 Sn}
      assign(T E)
   else
      S1=Sn
      raise error(S1) end
   end
end

fun {Prog S1 Sn} % quite literal description of <Prog> ::= program <Identifier> ; <Statement> end
   Y Z S2 S3 S4 S5 in
   S1=program|S2
   Y={Id S2 S3}
   S3=';'|S4
   Z={Stat S4 S5}
   S5='end'|Sn
   prog(Y Z)
end

fun {Sequence NonTerm Sep S1 Sn}
   X1 S2 T S3 in
   X1={NonTerm S1 S2} % use passed function function to parse first non-terminal occrance 
   S2=T|S3 % now with the rest, get T as the new head
   if {Sep T} then X2 in % if it's the separator we're looking for, then continue parsing recursively
      X2={Sequence NonTerm Sep S3 Sn}
      T(X1 X2) % dynamically create nested record
   else % this was the last one, no separator
      S2=Sn % so we know the rest which to return
      X1 % and we return the only parsed thing in this sequence
   end
end

% these all refer to Sqeuence to do the real work
fun {Comp S1 Sn} {Sequence Expr COP S1 Sn} end
fun {Expr S1 Sn} {Sequence Term EOP S1 Sn} end
fun {Term S1 Sn} {Sequence Fact TOP S1 Sn} end

% these just check if they were passed the right tokens, -> Bool
fun {COP Y}
   Y=='<' orelse Y=='>' orelse Y=='=<' orelse Y=='>=' orelse Y=='==' orelse Y=='!='
end
fun {EOP Y} Y=='+' orelse Y=='-' end
fun {TOP Y} Y=='*' orelse Y=='/' end

fun {Fact S1 Sn}
   T|S2=S1 in % the head is T, S1 is the tail
   if {IsInt T} orelse {IsIdent T} then % we've got an int or an atom/identifier
      S2=Sn
      T
   else E S2 S3 in % expression inside parentheses we need to parse
      S1='('|S2
      E={Expr S2 S3}
      S3=')'|Sn
      E
   end
end

fun {IsIdent X} {IsAtom X} end % identifier is just an Oz atom

% you assert something just by writing it = true. Sn is the return value: remaining list, S1 is input list, we return parsed identifier
fun {Id S1 Sn} X in S1=X|Sn true={IsIdent X} X end


%%% use

declare A Sn in
A = {Prog
     [program foo ';'
      while a '+' 3 '<' b 'do' b ':=' b '+' 1 'end']
     Sn}
{Browse A}