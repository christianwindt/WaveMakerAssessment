clear all
close all
sim=system('rm *.png');

addpath('~/octavescripts/matlab2tikz/src/')
pkg load signal
timeStep=0.01;
Tol=1E-5; %RMS Error of surface elevation

%Bound crazy predictions
bound=10;
probepos=7;
Nattempts=15;
%Load targetdata
%load('smalltestwave.mat')
wave=load('Targeteta_1BT3.mat');
Time1=wave.Time;
Elevation1=wave.Elevation-mean(wave.Elevation);
%load('Targetdata.mat');

Timesteps=(min(Time1):timeStep:max(Time1))-min(Time1);
targetEta=(interp1(Time1-min(Time1),Elevation1,Timesteps));

[targetetafreq, targetetaamp, targetetavar, targetetaphase] = spectrum_from_trace(targetEta, timeStep);

 figure(1,"visible","off");
 subplot(3,1,1)
 plot(Timesteps,targetEta)
subplot (3, 1, 2)
plot(targetetafreq,targetetaamp)
axis([0 7])
subplot (3, 1, 3)
plot(targetetafreq,targetetaphase)
axis([0 7])
filename=['targetEtaspec' ]
print(filename,'-dpng')
close
%targetEta=num2cell(targetEta(floor(delay/timeStep)+1:end));%Remove zero at
%start if needed
load('Initialwavemakerinput.mat');
%Interpolate to make sure same length of timetrace
Uorig=cell2mat(U);

U=U';
eta=[];
mse=zeros(Nattempts,1);
msre=zeros(Nattempts,1);
i=1;
while ( i<Nattempts),
    %Run simulation
    sim=system('./Runcase.sh');
    %load resulting elevation and adjust timestep
    etaResult=load('Elevation.mat','-ascii');
    Depth=3;%mean(etaResult(:,2));
    %etaResult=interp1(etaResult(:,1),etaResult(:,2),(timeStep:timeStep:timeStep*(size(U,2)-size(eta,2))));
    etaResult=interp1(etaResult(:,1),etaResult(:,2),(timeStep:timeStep:timeStep*(size(U,2))));
    %Replace NaN at start with mean
    etaResult(isnan(etaResult))=0;
    etaResult=etaResult;
    
    %Check if achieved Tol
    figure(1,"visible","off");
    plot((timeStep:timeStep:timeStep*(size(U,2))),etaResult,'b');
    hold on;
     %plot(Timesteps,targetEta,'r');
     
     [corr,lag] = xcorr(targetEta,eta);
     [value,index]=max(corr);
     shiftedEta=shift(targetEta,-lag(index));
     plot(Timesteps,shiftedEta,'g')
    legend('Result','Targetadjusted');
    filename=['ResultandTarget' num2str(i)]
    print(filename,'-dpng')
    %cleanfigure;
    %matlab2tikz([filename '.tikz']);
    close;
    if (size(etaResult)==size(targetEta))
        mse(i)=sum((shiftedEta-etaResult).^2);
        msre(i)=sum((shiftedEta-etaResult).^2/shiftedEta.^2)/length(shiftedEta);
    else
        mse(i)=inf;
        msre(i)=inf;
    end
    
    %if ((msre(i)<Tol)||i>Nattempts)
     %   close all;
     %   break;
    %end
    eta=etaResult;
    if (size(eta,2)==size(U,2))
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Create wavemaker input by adjusting phaseangles and amplitudes
            dt=timeStep;
            depth=Depth;
            x_probe=probepos;
            Umat=cell2mat(U);
        [etafreq, etaamp, etavar, etaphase] = spectrum_from_trace(eta, dt);
        
        
        figure(1,"visible","off");
        subplot (2, 1, 1)
        plot(etafreq,etaamp,'g')
        hold on
        plot(etafreq,targetetaamp,'r')
        axis([0 7])
        subplot (2, 1, 2)
        plot(etafreq,etaphase,'g')
        hold on
        plot(etafreq,targetetaphase,'r')
        axis([0 7])
        filename=['etaspec'  num2str(i)]
        print(filename,'-dpng')
        close;
        [Ufreq, Uamp, Uvar, Uphase] = spectrum_from_trace(Umat, dt);
        
        Unewamp=targetetaamp.*Uamp./etaamp;

        phi_paddle=zeros(size(Unewamp));
        %Correct for distance to wavemaker!
         for j = 1:length(etaphase)
             %if Unewamp(j) < 10^(-3)
                    %phi_paddle(j) = 0;
             %else
                [k(j), w_length(j)] = wave_number_NR(2*pi*etafreq(j),depth);
                phi_paddle(j) = angle(targetetaphase(j)+k(j)*x_probe);
            %end
        end
        
        Unewphase=targetetaphase-etaphase+Uphase;

        Ampmat=zeros(length(Unewamp),length(Unewamp));
        Ampmat(:,1)=Unewamp;
        phimat=zeros(length(phi_paddle),length(phi_paddle));
        phimat(:,1)=Unewphase;
        
        
        L = 2*length(targetetaamp);
        %df=diff(targetetafreq(1:2))
        df = 1/(2*timeStep*(L));

        [time_trace, dt] = trace_from_spectrum(Ampmat, phimat, df);
        
         figure(1,"visible","off");
        subplot (2, 1, 1)
        plot(Ufreq,Uamp,'g')
        axis([0 7])
        hold on
        plot(Ufreq,Unewamp,'r')
        axis([0 7])
        subplot (2, 1, 2)
        plot(Ufreq,Uphase,'g')
        hold on
        plot(Ufreq,phi_paddle,'r')
        axis([0 7])
        filename=['Overview'  num2str(i)]
        print(filename,'-dpng')
        close;
        Unew=time_trace(:,1);
        Unew(isnan(Unew))=0.;
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %Ramp up over ramp
                %ramptime=2;
                %L=length(Unew);
                %t = tukeywin(L,0.9);
                %Unew=t.*Unew;

            newtime=(0:dt:dt*(length(Unew)-1));
            figure(1,"visible","off");
            plot(newtime,Unew,'r');
            %hold on
            %plot(Timesteps,Uorig,'g')
            legend('new')
            filename=['Unew' num2str(i)]
            print(filename,'-dpng')
            close;
    else
        error('size(eta,2)==size(U,2)');
    end
    
    %Bound to avoid divergence of wavemaker
    %Unew=cell2mat(Unew);
    %Unew(Unew>bound)=bound;
    %Unew(Unew<-bound)=-bound;

%Interpolate  down to maintain frequency
    Unewds=interp1(newtime,Unew,Timesteps);
    Unewds(isnan(Unewds))=0;
    
    Unewds=num2cell(Unewds);
    
    %U=[U Unew];
    U=Unewds;
    %startuptime

    %Unew=[Unew num2cell(zeros(size((Time(end)+timeStep:timeStep:Time(end)+delay))))];
    %Timestepsnew=(dt:dt:size(Unew,2)*dt);
   
    Output=[Timesteps',cell2mat(Unewds)',zeros(size(cell2mat(Unewds)))',zeros(size(cell2mat(Unewds)))'];
    %Write new Wavemakerinputfile
    fid = fopen('Wavemaker.dat', 'w');
    fprintf(fid,'%i\n', size(Unewds,2));
    fprintf(fid,'(\n');
    fprintf(fid,'(%f ( %f %f %f ))\n',Output');
    fprintf(fid,')\n');
    fclose(fid);
    close all;
    whos U eta
    filename=['Rundata' num2str(i) '.mat']
    save('-V7',filename)
    i=i+1
end

figure;
%plot(mse(2:end-1),'b');
plot(msre(2:end-1),'r');
filename=['ERROR']
print(filename,'-dpng')
%cleanfigure;
%matlab2tikz([filename '.tikz']);

save('-V7','Rundata.mat')
