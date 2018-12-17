clear all
close all

pkg load signal
timeStep=0.01;
Tol=1E-5; %RMS Error of surface elevation
startTime = 50;
endTime = 150;
Period = 8;
%Bound crazy predictions
bound=10;
probepos=7;
Nattempts=15;
%Load targetdata
%load('smalltestwave.mat')
wave=load('Targeteta.mat');
Time1=wave.Time;
Elevation1=wave.Elevation-mean(wave.Elevation);
%load('Targetdata.mat');

Timesteps=(min(Time1):timeStep:max(Time1))-min(Time1);
targetEta=(interp1(Time1-min(Time1),Elevation1,Timesteps));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    upcross = find(targetEta(1:end-1) < 0 & targetEta(2:end) >= 0); % downcrossing
    j=1;
    Periods=NaN([length(upcross) length(targetEta)]);
    % Loop to go through all zero crossings
    for i=1:length(upcross)%-1
        % get indeProbeLoc of zero crossing: Start of Period
        idProbeLoc0=upcross(i);
        if Timesteps(idProbeLoc0)>=startTime && Timesteps(idProbeLoc0)<=(endTime-6.66)
            % define temporary period vector start till end of period
            %P_TMP=FSE(idProbeLoc0:idProbeLoc1);
            P_TMP=targetEta(idProbeLoc0:(idProbeLoc0+((Period*0.9)/timeStep)));
            % define vector to track number of periods after start time
            j_track(j)=j;
            % define vector to track length of temporary period vector
            l_track(j)=length(P_TMP);
            % fills pre-defined periods matriProbeLoc with values of temporary
            % period vector
            for jj=1:length(P_TMP);
                Periods(j,jj)=P_TMP(jj);
            end
           Hmax(j)=max(Periods(j,:));
           Hmin(j)=min(Periods(j,:));
           j=j+1;
        end
    end
    Hmax=mean(Hmax);
    Hmin=mean(Hmin);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



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
    %sim=system('./Runcase.sh');
    %load resulting elevation and adjust timestep
    etaResult=load('Elevation.mat','-ascii');
    Depth=70;%mean(etaResult(:,2));
    %etaResult=interp1(etaResult(:,1),etaResult(:,2),(timeStep:timeStep:timeStep*(size(U,2)-size(eta,2))));
    etaResult=interp1(etaResult(:,1),etaResult(:,5),(timeStep:timeStep:timeStep*(size(U,2))));
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
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    upcross = find(eta(1:end-1) < 0 & eta(2:end) >= 0); % downcrossing
    j=1;
    Periods=NaN([length(upcross) length(eta)]);
    % Loop to go through all zero crossings
    for xx=1:length(upcross)%-1
        % get indeProbeLoc of zero crossing: Start of Period
        idProbeLoc0=upcross(xx);
        if Timesteps(idProbeLoc0)>=startTime && Timesteps(idProbeLoc0)<=(endTime-6.66)
            % define temporary period vector start till end of period
            %P_TMP=FSE(idProbeLoc0:idProbeLoc1);
            P_TMP=eta(idProbeLoc0:(idProbeLoc0+((Period*0.9)/timeStep)));
            % define vector to track number of periods after start time
            j_track(j)=j;
            % define vector to track length of temporary period vector
            l_track(j)=length(P_TMP);
            % fills pre-defined periods matriProbeLoc with values of temporary
            % period vector
            for jj=1:length(P_TMP);
                Periods(j,jj)=P_TMP(jj);
            end
           Hmax_Result(j)=max(Periods(j,:));
           Hmin_Result(j)=min(Periods(j,:));
           j=j+1;
        end
    end
    Hmax_Result=mean(Hmax_Result);
    Hmin_Result=mean(Hmin_Result);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        dHmax = Hmax/Hmax_Result;
        dHMin = Hmin/Hmin_Result;
        
        for ll=1:length(Umat)
          if Umat(ll)>=0
            Unew(ll) = Umat(ll)*dHmax;
          else
            Unew(ll) = Umat(ll)*dHMin;
          end
        end
        
                
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
