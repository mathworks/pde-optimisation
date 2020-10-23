function myConductivity = xlpeConductivity(~, state)
%XLPECONDUCTIVITY Return the non-linear conductivity for XLPE insulators
%   This function takes the input state and location and returns an
%   estimate of the non-linear thermal conductivity of an XLPE insulator.
%   It is based on public information, such as that from Thermal and
%   Mechanical Properties of EPR and XLPE Cable Compounds, Xiaoguang Qi and
%   Steven Boggs, IEEE Electrical Insulation Magazine, Vol 22, Issue 3,
%   2006.
%
%   Input/s:
%       -) location: PDE location structure
%       -) state: PDE state structre
%
%   Output/s:
%       -) myConductivity: vector of thermal conductivities
%
%   Copyright © 2020 The MathWorks, Inc.

%% Parameter Values
persistent refT refTC
if isempty(refT) || isempty(refTC)
    refT =  [-1000  20     37    59    86    90   102   111   122   139 1000] + 273.3;
    refTC = [0.330 0.330 0.332 0.312 0.328 0.365 0.385 0.280 0.255 0.265 0.265];
end

%% Computations
myConductivity = interp1(refT, refTC, state.u, 'linear');

end

