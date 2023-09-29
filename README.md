# Optimisation of Current Carrying Cables
## Introduction
This demonstration shows a combination of:

1. Finite element analysis (FEA) of solid body heat transfer with non-linear material properties
1. Optimisation of an output of the FEA

specifically related to a real world problem.  We walk through the general process, which is:

1. Generate a representative FEA solver wrapped into a function
1. Use Surrogate Optimisation to find a close, but fast, approximation of the global optimum
1. Deploy a local solver based on the output of the Surrogate Optimisation to polish and find the global optimum 

We will look at the case of a current carrying conductor that is buried underground.  In this case we want to maximise the current that can be carried subject to the insulator staying below a fixed temperature.  See the domain sketch below.

![Sketch of the computational domain and problem configuration](domainSketch.png "Sketch of the computational domain and problem configuration")

## Requirements
We use the following tools within this demonstration:

1. MATLAB &reg; (≥2020b), see note below
1. Partial Differential Equation Toolbox &trade;
1. Optimisation Toolbox &trade;
1. Global Optimisation Toolbox 
1. Parallel Computing Toolbox &trade;

The demonstration will work with versions of MATLAB earlier than 2020b but as we are using the Optimsation Live Task that is released in 2020b those sections will be limited to code only.

## Getting Started
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=mathworks/pde-optimisation&project=conductorOptimisation.prj)

Open the project file, conductorOptimisation.prj, which will in turn configure the environment and launch a number of live scripts into the editor.  Start with the script: demonstrationOverview.mlx.

## File Exchange
Also available for direct download on MATLAB File Exchange

[![View pde-optimisation on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://au.mathworks.com/matlabcentral/fileexchange/81618-pde-optimisation)

## Copyright

Copyright © 2020 - 2023 The MathWorks, Inc.