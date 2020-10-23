function [c, ceq] = myNonLinCon(myCurrent, tMax)
%MYNONLINCON Compute non-linear constraints for fmincon
%   MYNONLINCON computes the non-linear constraints for fmincon.
%
%   Input/s:
%       -) myCurrent: present value of the current (Amps) to estimate the
%           inequalities for.
%       -) tMax: maximum permissible temperature.
%
%   Output/s:
%       -) c: inequality array
%       -) ceq: empty
%
%   Copyright © 2020 The MathWorks, Inc.

c = tMax - maxTFromCurrent(myCurrent);
ceq = [];

end

