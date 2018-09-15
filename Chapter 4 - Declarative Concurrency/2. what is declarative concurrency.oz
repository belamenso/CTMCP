thread
   proc {Count N} if N == 0 then skip else {Count N-1} end end
in
   {Count 1000000}
   {Browse 'I am done'}
end

{Browse 'I was never in that thread so i am executed immediately'}
{Browse thread 100 end}

thread {Browse 111} end
{Browse 222}

% browse updated partial values that were bound after the first display!
declare Z

{Browse Z}

Z="Hello there!"

declare X1 X2 Y1 Y2 
thread {Browse X1} end
thread {Browse Y1} end
thread X1=all|roads|X2 end
thread Y1=all|roams|Y2 end
thread X2=lead|to|rome|nil end
thread Y2=lead|to|rhodes|nil end

declare fun {Stream L H}
	   {Delay 300}
	   if L > H then nil else L|{Stream L+1 H} end
	end

{Browse thread {Stream 1 10} end}