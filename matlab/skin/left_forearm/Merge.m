function [ vystup ] = Merge( a, b )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
vystup = [0,0,0,0,0,0];
vystup(1,1) = min([a(1,1), b(1,1)]); 
vystup(1,2) = min([a(1,2), b(1,2)]);
vystup(1,3) = min([a(1,3), b(1,3)]);
vystup(1,4) = max([a(1,4), b(1,4)]);
vystup(1,5) = max([a(1,5), b(1,5)]);
vystup(1,6) = max([a(1,6), b(1,6)]);
end

