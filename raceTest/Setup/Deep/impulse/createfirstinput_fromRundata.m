%Create random trace to initialise AI learning
close all
clear all
load('Rundata3.mat');
%Write new Wavemakerinputfile
    fid = fopen('Wavemaker.dat', 'w');
    fprintf(fid,'%i\n', size(Unewds,2));
    fprintf(fid,'(\n');
    fprintf(fid,'(%f ( %f %f %f ))\n',Output');
    fprintf(fid,')\n');
    fclose(fid);
    close all;
