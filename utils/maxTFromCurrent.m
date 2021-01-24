function tMax = maxTFromCurrent(current)
%MAXTFROMCURRENT Compute the maximum temperature for a given current
%   maxTFromCurrent is essentially a wrapper around soilFEAHeatSourceInsul
%   that returns the maximum within the solution.
%
%   Input/s:
%       -) current: target current for this simulation
%
%   Output/s:
%       -) tMax: inverse of the simulated maximum temperature
%
%   Copyright © 2021 The MathWorks, Inc.


%% Constants
kToC = 273.3;
tSoil = 14;
cableArea = 300 / 1e6; % 300mm^2 in m^2

%% Create the Geometry
% Geometry stays constant for this run so we can save time by reusing
persistent dl
if isempty(dl)
    dl = generateGeom_Insulator();
end

% Set some constants, which are read by hand from the figure
% Face indices
faceSoil = 1;
faceCond = 2;
faceSand = 3;
faceTrench = 4;
faceInsul = 5;

% Edge groups:
edgeSoil = 1:1:3;
edgeAir = 7:1:9;

%% Set up Empty Thermal Model and Mesh
thermalmodel = createpde('thermal', 'transient');
geometryFromEdges(thermalmodel, dl);
generateMesh(thermalmodel,...
    'Hgrad', 1.1,...
    'Hmax', 0.05, ...
    'Hmin', 0.0001);

%% Set Thermophysical Constant Properties
% Outer soil
thermalProperties(thermalmodel,...
    'Face', faceSoil, ...
    'ThermalConductivity', 0.2, ...
    'MassDensity', 2000 , ...
    'SpecificHeat', 0.290);

%Inner sand, saturated
thermalProperties(thermalmodel,...
    'Face', faceSand, ...
    'ThermalConductivity', 2.0, ...
    'MassDensity', 1000 , ...
    'SpecificHeat', 0.290);

% Trench backfill
thermalProperties(thermalmodel,...
    'Face', faceTrench, ...
    'ThermalConductivity', 1, ...
    'MassDensity', 1000 , ...
    'SpecificHeat', 0.290);

%% Boundary Conditions
thermalBC(thermalmodel, ....
    'Edge', [edgeSoil edgeAir], ...
    'Temperature', tSoil + kToC);

%% Initial Conditions
% Set initial conditions
thermalIC(thermalmodel, ...
    tSoil + kToC);

%% Set Up The Conductor and Insulator
% Cable
% Cable parameters
cableState.I = current; % Amps
cableState.Area = cableArea;

thermalProperties(thermalmodel,...
    'Face', faceCond, ...
    'ThermalConductivity', 237, ...
    'MassDensity', 2700, ...
    'SpecificHeat', 900);

internalHeatSource(thermalmodel, ...
    @(r,s) powerFromResistivity(r, s, cableState), ...
    'Face', faceCond);

% Insulator
% Assume non-linear thermal conductivity of the XLPE insulator
thermalProperties(thermalmodel,...
    'Face', faceInsul, ...
    'ThermalConductivity', @xlpeConductivity, ...
    'MassDensity', 2700, ...
    'SpecificHeat', 900);

% Setting up the solution time vector in seconds first, then run.
tlist = 0:100:100000;
R = solve(thermalmodel,tlist);

%% Extract maximum temperature And convert
tMax = max(R.Temperature(:,end));

end

