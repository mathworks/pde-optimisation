function f = objConstructor(myCurrent, tMax)
%OBJCONSTRUCTOR Objective function for surrogateop
%   OBJCONSTRUCTOR is a constructor function to be used as an input for the
%   surrogateopt routine.
%
%   Input/s:
%       -) myCurrent: present value of the current (Amps) to calculate the
%           temperature from.
%       -) tMax: the maximum temperature permissible in the domain in
%           Kelvin.
%
%   Output/s:
%       -) f: structure containing Fval and Ineq suitable for surrogatopt
%
%   Copyright © 2020 - 2023 The MathWorks, Inc.

f.Fval = maxTFromCurrent(myCurrent);
f.Ineq = tMax - f.Fval;
end

