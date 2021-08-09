function [ i ] = invertir( i )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

for n=1: size(i,1)
for m=1: size(i,2)
if(i(n,m)==1)
i(n,m)=0;
else
i(n,m)=1;
end
end
end
end

