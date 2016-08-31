%*********************************************************************** 
%									 
%	-- Loads all the chracteristic values of the system
%   and calculates the air losses.
%
%   The type of the parameter must be one of the following:
%   -p	Input power
%   -l	Point losses in the system
%   -g	Point gains in the system
%
%   Usually, there should only be one 'Input Power', but the program will accept
%   more than one.
%
%	-> Usage = 
%		-> [airLosses,systemInfo] = systemLinkBudget(data,systemFile)
%
%	-> inputs =
%       -> system - STRING pointing to the path of the .txt file that
%       stores the system characteristics
%		-> pow  - ARRAY OF FLOATS with measures of power (in dB)
%		-> att  - ARRAY OF FLOATS with attenuation levels of each measure
%	
%	-> outputs = 	
%		-> [airLosses,systemInfo] = systemLinkBudget(data,systemFile)
%								 
%	-> MATLAB version used:	
%		- R2012b (8.0.0.783) 64-bit	
%				 
% 	-> Special toolboxes used: 
%       -- none --
%
% 	-> Other dependencies:  
%       -- none --
%									 
%	-> Created by Evandro Bernardes	 								 
%		- at ENSTA Bretagne (Brest, Britanny, France)							 								 
%		- In association with: 
%			ANFR - Agence Nationale de Fréquence    		 
%									 
% 	Code version:	2.0
%
%	last edited in:	30/08/2016 					 
%									 
%*********************************************************************** 
function [airLosses,systemInfo] = systemLinkBudget(data,systemFile)

    fileID = fopen(systemFile);
	
    % read measures as strings
	pattern = '-%c %s %f';
    rawData = textscan(fileID,pattern,'CommentStyle','%');
    
    
    % extraction of variables   
    type = rawData{1};
    variable = rawData{2};
    value = rawData{3};
    
    pow = data.pow;
    att = data.att;
    inputPower = sum(value(type == 'p'));    % input power
    otherGains = sum(value(type == 'g'));  % sum of gains
    otherLosses = sum(value(type == 'l'));  % sum of losses
    
    % calculated losses between the antennae
    airLosses = (inputPower + otherGains) - (pow + att + otherLosses);
    airLosses = struct('value',airLosses,'time',data.time);
    
    % system info
    systemInfo = struct('type',type,'variable',variable,'value', value);
end
