declare
fun {NewDictionary} nil end
fun {Put Ds Key Value}
   case Ds
   of nil then [Key#Value]
   [] (K#V)|Dr andthen K==Key then (Key#Value)|Dr
   [] (K#V)|Dr andthen K>Key then (Key#Value)|(K#V)|Dr
   [] (K#V)|Dr andthen K<Key then (K#V)|{Put Dr Key Value}
   end
end
fun {GetDefault Ds Key Default}
   case Ds
   of nil then Default
   [] (K#V)|Dr andthen K==Key then Value
   [] (K#V)|Dr andthen K>Key then Default
   [] (K#V)|Dr andthen K<Key then {GetDefault Dr Key Default}
   end
end
fun {Domain Ds}
   {Map Ds fun {$ K#_} K end}
end
