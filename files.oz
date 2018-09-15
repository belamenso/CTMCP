declare [File] = {Module.link ['File.ozf']}

local L in
   L={File.readList "mergesort.oz"}
   {Browse L}
end

{Browse ala#'.'#hello}

{File.writeOpen 'a.txt'}
{File.write ala#' '#"nie ma kota"}
{File.writeClose}