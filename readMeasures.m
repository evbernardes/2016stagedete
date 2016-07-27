%*********************************************************************** 
%									 
%	-- Read data from a file generated by the LabView application
%
%	-> Usage = 
%		-> [pow,time,att] = readMeasures(filename)
%
%	-> inputs =
%		-> filename - STRING defining name and location of file
%	
%	-> outputs = 	
%		-> pow  - ARRAY OF FLOATS with measures of power (in dB)
%		-> time - ARRAY OF STRINGS with dates of measures
%		-> att  - ARRAY OF FLOATS with attenuation levels of each measure
%									 
%	-> MATLAB version used:	
%		- R2012b (8.0.0.783) 64-bit	
%				 
% 	-> Special toolboxes used: 
%		-- none	--
%
% 	-> Other dependencies: 
%		- myCell2Mat.m
%									 
%	-> Created by Evandro Bernardes	 								 
%		- at ENSTA Bretagne (Brest, Britanny, France)							 								 
%		- In association with: 
%			ANFR - Agence Nationale de Fréquence    		 
%									 
% 	Code version:	2
%   - v2: addition of "myCell2Mat.m" script
%
%	last edited in:	25/07/2016 					 
%									 
%*********************************************************************** 

% Function declaration
function [pow,time,att] = readMeasures(filename)

	fileID = fopen(filename);
	
    % read measures as strings
	pattern = '%s %s %s';
    rawData = textscan(fileID,pattern);
    
    % extraction of "power" float array    
    pow = myCell2Mat(rawData{1});

    % extraction of "time" string array    
    time = rawData{2};
    time = cell2mat(time);
    
    % extraction of "attenuation" float array    
    att = myCell2Mat(rawData{3});
end
