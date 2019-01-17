function [data, dataColumnHeaders] = ...
    time_series(inputDir, outputDir, invalidruns)
%% step 8: 
% This function is used for the HyICE2018 campaign, to plot the time serie

%% Load data from last step
FileName   = 'data.mat';
File       = fullfile(inputDir, FileName);
data = load(File); %struct
data = data.data ; %table 

FileName1 = 'dataColumnHeaders';
File1       = fullfile(inputDir, FileName1);
dataColumnHeaders=load(File1);
dataColumnHeaders=dataColumnHeaders.dataColumnHeaders;

%% Remove the invalid data (noted unvalid in the diary)
% The runs concerned are: run 40, Run 49, Run 50, Run 51 & Run 63
for i=invalidruns
    data(data(:,5)==i,:)=[];
end
L=length(data);
% Remove also negative INP values (replaced by NaN)
for i=1:L
    if (data(i,3)<0)
        data(i,3)=NaN;
    end
end


%% Calcutate the time to display the data (half time between start and end time)
all_times=[data(:,1) data(:,2)];
half_time=[];
for i=1:length(all_times)
    half_time(i)=mean(all_times(i));
end
half_time=half_time';
data=[data(:,1) data(:,2) half_time data(:,3) data(:,4) data(:,5)];

%% Plot the time serie
figure('units','normalized','outerposition',[0 0 1 1])
e=errorbar(data(:,3), data(:,4),data(:,5),'o');
e.MarkerFaceColor=[0 0.45 0.74];
e.Color=[0.3 0.75 0.93];
xlabel('Time (UTC)');
ylabel('INP concentration (#/std L)');
ylim([-10;220]);
xmin=addtodate(data(1,2),-1,'day');
xmax=addtodate(data(length(data),2),1,'day');
xlim([xmin xmax]);
datetick('x', 'mmm dd','keeplimits')
grid on

print('-dpng','-r300', '-painters', [outputDir, '/PINCii_final_time_serie', '.png'])
saveas(gcf,[outputDir, '/PINCii_final_time_serie', '.fig'])

%% Save the data
filename=strcat(outputDir,'\data');
save(filename,'data');
% column headers 
dataColumnHeaders={'start_time(UTC)','end_time(UTC)','half_time(UTC)','INP','Uncertainty','Run number'};
save([outputDir, '/dataColumnHeaders.mat'], 'dataColumnHeaders') ;
end




