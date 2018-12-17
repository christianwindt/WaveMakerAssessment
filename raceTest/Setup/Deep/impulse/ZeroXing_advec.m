function [HW, stdHW, FSE, Timesteps]...
    = ZeroXing_advec( t,Eta,T,plotTrace,startTime, endTime,TimeRes )
   %% Add Theory to D
    Timesteps=(min(t):TimeRes:max(t));
    FSE=(interp1(t,Eta,Timesteps,'spline'));
    %%
    %% ZeroCrossing Analysis for Medium
    % define cut off indeProbeLoc based on user defined start time
%     cutOff = find(Timesteps(1:end) == startTime);
    % perform zero cross (either down or up) by going trough FSE data
    upcross = find(FSE(1:end-1) < 0 & FSE(2:end) >= 0); % downcrossing
    %         downcross = find(FSE(1:end-1) <= 0 & FSE(2:end) > 0); % upcrossing
    % set j counter to be 1 (used to track number of Periods after start time) 
    if plotTrace == 1
        figure;
        plot(Timesteps,FSE);
        grid on; hold on;
        plot(Timesteps(upcross),FSE(upcross),'ro');
    end
    j=1;
    % Define MatriProbeLoc with NaN to be filled with FSE values for each
    % Period after start time
    Periods=NaN([length(upcross) length(FSE)]);
    % Loop to go through all zero crossings
    for i=1:length(upcross)%-1
        % get indeProbeLoc of zero crossing: Start of Period
        idProbeLoc0=upcross(i);
        % get indeProbeLoc of zero crossing: End of Period
        %idProbeLoc1=upcross(i+1);
        % check if start of Period occurs after user define start time
        if Timesteps(idProbeLoc0)>=startTime && Timesteps(idProbeLoc0)<=(endTime-6.66)
            % define temporary period vector start till end of period
            %P_TMP=FSE(idProbeLoc0:idProbeLoc1);
            P_TMP=FSE(idProbeLoc0:(idProbeLoc0+((T*0.9)/TimeRes)));
    %                 P_TMP=FSE(idProbeLoc0:(idProbeLoc0+1));
            % define vector to track number of periods after start time
            j_track(j)=j;
            % define vector to track length of temporary period vector
            l_track(j)=length(P_TMP);
            % fills pre-defined periods matriProbeLoc with values of temporary
            % period vector
            for jj=1:length(P_TMP);
                Periods(j,jj)=P_TMP(jj);
            end

    %             plot((0:OutputInterval:(length(P_TMP)-1)*OutputInterval),P_TMP);hold on;grid on;
        HW(j)=max(Periods(j,:))-min(Periods(j,:));
        j=j+1;
        end
    end
%     HW1=max(Periods(1,:))-min(Periods(1,:));
%     HW2=max(Periods(2,:))-min(Periods(2,:));
%     HW3=max(Periods(3,:))-min(Periods(3,:));
%     dH=HW1-HW2
%     HW=[HW1,HW2,HW3];
    stdHW=std(HW);
%     % prune number of rows with number of periods
%     Periods(max(j_track)+1:length(Periods(:,1)),:)=[];
%     % prune number of columns with maProbeLoc. length of all periods
%     Periods(:,max(l_track)+1:length(Periods(1,:)))=[];
%     % set all NaN to 0; is the case if temporary period vectors were
%     % shorter than the maProbeLoc. length of any temporary period vector
%     Periods(isnan(Periods))=0;
%     PeriodsMean=zeros(length(Periods(1,:)),1);
%     PeriodsStd=zeros(length(Periods(1,:)),1);
%     % calculate mean and standard deviation from all periods;
%     % calculation is made over all periods for one time step
%     for l=1:length(Periods(1,:))
%        PeriodsMean(l)=mean(Periods(:,l));
%        PeriodsStd(l)=std(Periods(:,l));
%     end
%     % Determine maProbeLoc. and min. amplitude (i.e. wave height) from mean
%     % period
%     maxAmp=max(PeriodsMean);
%     minAmp=min(PeriodsMean);
%     % get maProbeLoc. and min. amplitude (i.e. wave height) including std.
%     maxAmpPlusSTD=max(PeriodsMean+PeriodsStd);
%     minAmpPlusSTD=min(PeriodsMean+PeriodsStd);
%     maxAmpMinusSTD=max(PeriodsMean-PeriodsStd);
%     minAmpMinusSTD=min(PeriodsMean-PeriodsStd);
%     % calculate wave height
% %     WaveHeight=maProbeLocAmp+abs(minAmp);
% %     WaveHeightPlusSTD=maProbeLocAmpPlusSTD+abs(minAmpMinusSTD);
% %     WaveHeightMinusSTD=maProbeLocAmpMinusSTD+abs(minAmpPlusSTD);
%     WaveHeight=maxAmp+abs(minAmp);
%     MaxWaveHeightSTD=maxAmpPlusSTD+abs(minAmpMinusSTD);
%     MinWaveHeightSTD=maxAmpMinusSTD+abs(minAmpPlusSTD);
%     % define time vector for period (based on the time resolution)
%     tt=(0:TimeRes:(length(Periods(1,:))-1)*TimeRes)';
%     
%     figure
%     plot(tt/max(tt),PeriodsMean','r','DisplayName',['Mean Probe Pos. [ProbeLoc] ' num2str(ProbeLoc)]);
%     %legend('off'); 
%     legend('show')
%     hold on;
%     plot(tt/max(tt),PeriodsMean'-PeriodsStd','b','DisplayName',['Std Probe Pos. [ProbeLoc] ' num2str(ProbeLoc)]);
%     plot(tt/max(tt),PeriodsMean'+PeriodsStd','b','DisplayName',['Std Probe Pos. [ProbeLoc] ' num2str(ProbeLoc)]);
%     legend('Mean Period','Std','Std');
%     grid on;
end

