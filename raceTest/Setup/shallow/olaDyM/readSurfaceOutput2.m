function [ t,D ] = readSurfaceOutput2
%READSURFACEOUTPUT Summary of this function goes here
%   Detailed explanation goes here
% if nargin==0
%     inDir= '.';
% end
% xy=[-75 0; -50 0; -25 0; 0 0; 25 0; 50 0; 75 0; 100 0];%; 125 0; 150 0; 175 0; 200 0; 225 0; 250 0; 275 0; 300 0]; % more than one probe: use ; as seperator
xy=[40.75 0 ;81.5 0;122.25 0 ;163 0;203.75 0 ;244.5 0 ;285.25 0; 179.3 0];
inDir='.';
%% STATIC NAMING OF SURFACES:
f05 = 'alpha.water_alpha0.5.raw';
f005 = 'alpha.water_alpha0.05.raw';
f095 = 'alpha.water_alpha0.95.raw';

alphas = [0.05 0.5 0.95];
%fNames = {f005, f05, f095};
fNames = {f005, f05, f095};

dirName = strcat(inDir,'/postProcessing/surfaceSampling/');
%% Collect time values
L = dir(dirName);
timeNames = {L(3:end).name};
N = length(timeNames);
t = zeros(N,1);
% Extract time vector
for ii=1:N
    t(ii) = str2double(timeNames{ii});
end
% Sort in ascending order and reorder timeNames
[t,I] = sort(t);

timeNames = timeNames(I);

%% Initialise data structure

% Output struct
D = cell(length(alphas),1);

%% Open and read each file:

for aa = 1:length(alphas)
    elev = zeros(N,length(xy(:,1)));
    
    for ii=1:N    
        
        n = strcat(dirName,timeNames{ii},'/',fNames{aa});
        fid=fopen(n,'r');
    
        if fid == -1
            disp(['Warning: file ' n ' not found. Moving to next file']);
        
        else
        
            % skip two header lines: 
            fgetl(fid);
            fgetl(fid);
            % Scan remaining file:
            dTmp = fscanf(fid,'%f%f%f%f\n',[4,inf])';
            dTmp=dTmp(:,1:3); % throw away the alpha value itself. Keep coordinate.
            
            % Get wave elevation:
            elev(ii,:)= probeSurface(dTmp,xy);
            
            
            %D{ii,aa} = dTmp(:,1:3);
            % Close fid
            fclose(fid);
            
            
        end
        
    end
    a=alphas(aa);
    disp(a) 
    D{aa} = elev; % save elevation
end


end % end of function 

% - - - - - END OF FILE - - - - - %

