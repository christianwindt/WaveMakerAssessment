function [elev] = probeSurface(D,xyPoints)
%% probeSurface will use output data from readSurfaceOutput.m [t and D]
% and use it to extract the elevation at the best matches for xyPoints in D
%
% xyPoints is a Np by 2 matrix, where each row has the x,y coordinate of a
% wave probe.

% output elev is a length(alfas) by 1 cell with each value being a
%  Nt by Np matrix of elevation for each time and point and alfa
%  value. (Nt = size(D,1), no. of saved times)

% Default tol value:
if nargin<3
    tol = 0.05;
end

% No. of points
Np = length(xyPoints(:,1));

% initialise output
elev=zeros(1,Np);

% tmp = zeros(Nt,Np);


% Do for each point
for xy = 1:Np
    % Subtract target value
    x=D(:,1)-xyPoints(xy,1);
    y=D(:,2)-xyPoints(xy,2);
    z=D(:,3);
    
    rs = zeros(2,2);
    % Find the 2 closest points:
    for nn=1:2
        
        [res,ind] = min(x'.^2+y'.^2);
        
        % Save values
        rs(nn,:) = [sqrt(res) z(ind)];
        
        % Remove values and repeat to find 2nd minimum 
        x(ind)=[];
        y(ind)=[];
        z(ind)=[];
    end
    
    % Interpolate the value from the 2 closest points %
    elev(1,xy) = ( rs(1,1)*rs(2,2) + rs(2,1)*rs(1,2) )/sum(rs(:,1));
        
end