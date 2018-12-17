function Val_Out = dispersion(Str_In_1,Val_In_1,Str_In_2,Val_In_2)
%dispersion calculates one of the three defining values of the Airy wave
%theory based on the input of the other two values
%   Input values are two of the following: T, lambda or d
%   Output value is the corresponding third entry
%   T       wave period time [s]
%   lambda  wave length [m]
%   d       water depth [m]
%
%   Example:  lambda = dispersion('T',10,'d',5)
%   Example2:      T = dispersion('lambda',10,'d',5)

if strcmp(Str_In_1,Str_In_2)
    error('Please provide more than one variable\n');
end

switch Str_In_1
    case 'T'
        w=2*pi/Val_In_1;
        if strcmp(Str_In_2,'lambda')
            k=2*pi/Val_In_2;
            Str_Out='d';
        elseif strcmp(Str_In_2,'d')
            d=Val_In_2;
            Str_Out='lambda';
        end
    case 'lambda'
        k=2*pi/Val_In_1;
        if strcmp(Str_In_2,'T')
            w=2*pi/Val_In_2;
            Str_Out='d';
        elseif strcmp(Str_In_2,'d')
            d=Val_In_2;
            Str_Out='w';
        end
    case 'd'
        d=Val_In_1;
        if strcmp(Str_In_2,'T')
            w=2*pi/Val_In_2;
            Str_Out='lambda';
        elseif strcmp(Str_In_2,'lambda')
            k=2*pi/Val_In_2;
            Str_Out='w';
        end
    otherwise
        error('Value of str1 not valid\n');
end

g = 9.81;

if strcmp(Str_Out,'w')
    w       = sqrt(g*k*tanh(k*d)); % Dispersion relationship
    Val_Out = 2*pi/w;
elseif strcmp(Str_Out,'lambda')
    f       = @(k) w^2-g*k*tanh(k*d); % Dispersion relationship
    k       = fzero(f,[0,1e99]);
    Val_Out = 2*pi/k;
elseif strcmp(Str_Out,'d')
    d       = 1/k*atanh(w^2/(g*k)); % Dispersion relationship
    Val_Out = d;
end
end
