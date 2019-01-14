clear all
close all

function [data_concentration_updated] = add_valve_status(inputDir, outputDir)

%    function used to add valve status for the 22nd and 23rd of April 2018
%    + 14th and 15th of May 2018
%    + 4th of June 2018
%    New file is named data_concentration_updated

%% Load the data
FileName   = 'data_concentration.mat';
File       = fullfile(inputDir, FileName);
data = load(File); %struct
data = data.data_concentration ; %table 


k=find(data(:,2)<datenum('23-Apr-2018 22:00:00'));

%% 22nd of April 2018
for i=1:length(k)
    if (data(i,2)>=datenum('22-Apr-2018 10:00:00')) && (data(i,2)<=datenum('22-Apr-2018 10:16:00'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('22-Apr-2018 10:30:45')) && (data(i,2)<=datenum('22-Apr-2018 10:45:45'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('22-Apr-2018 11:00:40')) && (data(i,2)<=datenum('22-Apr-2018 11:15:00'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('22-Apr-2018 10:16:00')) && (data(i,2)<=datenum('22-Apr-2018 10:30:45'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('22-Apr-2018 10:45:45')) && (data(i,2)<=datenum('22-Apr-2018 11:00:40'))
        data(i,71)=0;
    end
end

%% 23rd of Apr 2018
for i=1:length(k)
    if (data(i,2)>=datenum('23-Apr-2018 09:20:01')) && (data(i,2)<=datenum('23-Apr-2018 09:40:31'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 09:40:31')) && (data(i,2)<=datenum('23-Apr-2018 09:55:31'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 09:55:31')) && (data(i,2)<=datenum('23-Apr-2018 10:10:41'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 10:10:41')) && (data(i,2)<=datenum('23-Apr-2018 10:25:41'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 10:25:41')) && (data(i,2)<=datenum('23-Apr-2018 10:40:31'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 10:40:31')) && (data(i,2)<=datenum('23-Apr-2018 10:56:36'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 10:56:36')) && (data(i,2)<=datenum('23-Apr-2018 11:35:01'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 12:22:30')) && (data(i,2)<=datenum('23-Apr-2018 12:36:01'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 12:36:01')) && (data(i,2)<=datenum('23-Apr-2018 12:50:56'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 12:50:56')) && (data(i,2)<=datenum('23-Apr-2018 13:15:11'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 13:15:11')) && (data(i,2)<=datenum('23-Apr-2018 13:30:31'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 13:30:31')) && (data(i,2)<=datenum('23-Apr-2018 13:45:31'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 13:45:31')) && (data(i,2)<=datenum('23-Apr-2018 14:01:31'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 14:01:31')) && (data(i,2)<=datenum('23-Apr-2018 14:19:06'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 14:19:06')) && (data(i,2)<=datenum('23-Apr-2018 14:45:51'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 14:45:51')) && (data(i,2)<=datenum('23-Apr-2018 14:19:06'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 14:19:06')) && (data(i,2)<=datenum('23-Apr-2018 14:45:51'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 14:45:51')) && (data(i,2)<=datenum('23-Apr-2018 15:20:31'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 15:20:31')) && (data(i,2)<=datenum('23-Apr-2018 15:35:26'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 15:35:26')) && (data(i,2)<=datenum('23-Apr-2018 15:50:31'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 15:50:31')) && (data(i,2)<=datenum('23-Apr-2018 16:05:01'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 16:05:01')) && (data(i,2)<=datenum('23-Apr-2018 16:20:06'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 16:20:06')) && (data(i,2)<=datenum('23-Apr-2018 16:35:36'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 16:35:36')) && (data(i,2)<=datenum('23-Apr-2018 16:50:31'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 16:50:31')) && (data(i,2)<=datenum('23-Apr-2018 17:05:36'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 17:05:36')) && (data(i,2)<=datenum('23-Apr-2018 17:21:06'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 17:21:06')) && (data(i,2)<=datenum('23-Apr-2018 17:35:36'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 17:35:36')) && (data(i,2)<=datenum('23-Apr-2018 17:50:16'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 17:50:16')) && (data(i,2)<=datenum('23-Apr-2018 18:05:26'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 18:05:26')) && (data(i,2)<=datenum('23-Apr-2018 18:20:21'))
        data(i,71)=1;
    elseif (data(i,2)>=datenum('23-Apr-2018 18:20:21')) && (data(i,2)<=datenum('23-Apr-2018 18:44:16'))
        data(i,71)=0;
    elseif (data(i,2)>=datenum('23-Apr-2018 18:44:16')) && (data(i,2)<=datenum('23-Apr-2018 19:01:36'))
        data(i,71)=1;
    end
end


%% 14th and 15th of May 2018 
% Run 26
start_datenum=datenum('13-May-2018 18:30:00');
start_datetime=datetime(start_datenum,'ConvertFrom','datenum');
end_datenum=datenum('14-May-2018 03:45:00'); 
end_datetime=datetime(end_datenum,'ConvertFrom','datenum');
total_duration=end_datetime-start_datetime; %total duration of the experiment, in datetime format
sample_duration= duration(0,15,0)'; %sample duration (should be 15 minutes)
sample_num=total_duration/sample_duration; %corresponding number of samples realized (should be odd since we start & end with background measurement)
s=zeros(sample_num,1);
e=zeros(sample_num,1);
start=start_datenum;
ends=addtodate(start_datenum,15,'minute');
% background loop (valve status=1)
for i=1:(sample_num/2)+1
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=1;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end
% sample loop (valve status =0)
start=addtodate(start_datenum,15,'minute');
ends=addtodate(start,15,'minute');
for i=1:sample_num/2
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=0;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end

% Run 27
start_datenum=datenum('14-May-2018 06:30:00');
start_datetime=datetime(start_datenum,'ConvertFrom','datenum');
end_datenum=datenum('14-May-2018 09:45:00'); 
end_datetime=datetime(end_datenum,'ConvertFrom','datenum');
total_duration=end_datetime-start_datetime; %total duration of the experiment, in datetime format
sample_duration= duration(0,15,0)'; %sample duration (should be 15 minutes)
sample_num=total_duration/sample_duration; %corresponding number of samples realized (should be odd since we start & end with background measurement)
s=zeros(sample_num,1);
e=zeros(sample_num,1);
start=start_datenum;
ends=addtodate(start_datenum,15,'minute');
% background loop (valve status=1)
for i=1:(sample_num/2)+1
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=1;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end
% sample loop (valve status =0)
start=addtodate(start_datenum,15,'minute');
ends=addtodate(start,15,'minute');
for i=1:sample_num/2
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=0;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end

% Run 28
start_datenum=datenum('14-May-2018 15:30:00');
start_datetime=datetime(start_datenum,'ConvertFrom','datenum');
end_datenum=datenum('14-May-2018 18:15:00'); 
end_datetime=datetime(end_datenum,'ConvertFrom','datenum');
total_duration=end_datetime-start_datetime; %total duration of the experiment, in datetime format
sample_duration= duration(0,15,0)'; %sample duration (should be 15 minutes)
sample_num=total_duration/sample_duration; %corresponding number of samples realized (should be odd since we start & end with background measurement)
s=zeros(sample_num,1);
e=zeros(sample_num,1);
start=start_datenum;
ends=addtodate(start_datenum,15,'minute');
% background loop (valve status=1)
for i=1:(sample_num/2)+1
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=1;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end
% sample loop (valve status =0)
start=addtodate(start_datenum,15,'minute');
ends=addtodate(start,15,'minute');
for i=1:sample_num/2
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=0;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end

% Run 29
start_datenum=datenum('14-May-2018 21:30:00');
start_datetime=datetime(start_datenum,'ConvertFrom','datenum');
end_datenum=datenum('15-May-2018 03:45:00'); 
end_datetime=datetime(end_datenum,'ConvertFrom','datenum');
total_duration=end_datetime-start_datetime; %total duration of the experiment, in datetime format
sample_duration= duration(0,15,0)'; %sample duration (should be 15 minutes)
sample_num=total_duration/sample_duration; %corresponding number of samples realized (should be odd since we start & end with background measurement)
s=zeros(sample_num,1);
e=zeros(sample_num,1);
start=start_datenum;
ends=addtodate(start_datenum,15,'minute');
% background loop (valve status=1)
for i=1:(sample_num/2)
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=1;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end
for i=13
    ends=datenum('15-May-2018 03:44:58');
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=1;

end
% sample loop (valve status =0)
start=addtodate(start_datenum,15,'minute');
ends=addtodate(start,15,'minute');
for i=1:sample_num/2
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=0;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end

% Run 30
start_datenum=datenum('15-May-2018 06:30:00');
start_datetime=datetime(start_datenum,'ConvertFrom','datenum');
end_datenum=datenum('15-May-2018 10:45:00'); 
end_datetime=datetime(end_datenum,'ConvertFrom','datenum');
total_duration=end_datetime-start_datetime; %total duration of the experiment, in datetime format
sample_duration= duration(0,15,0)'; %sample duration (should be 15 minutes)
sample_num=total_duration/sample_duration; %corresponding number of samples realized (should be odd since we start & end with background measurement)
s=zeros(sample_num,1);
e=zeros(sample_num,1);
start=start_datenum;
ends=addtodate(start_datenum,15,'minute');
% background loop (valve status=1)
for i=1:(sample_num/2)
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=1;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end
for i=9
    ends=datenum('15-May-2018 10:44:58');
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=1;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end
% sample loop (valve status =0)
start=addtodate(start_datenum,15,'minute');
ends=addtodate(start,15,'minute');
for i=1:sample_num/2
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=0;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end

%% 4th of June 2018
% Run 51
start_datenum=datenum('04-Jun-2018 09:00:00');
start_datetime=datetime(start_datenum,'ConvertFrom','datenum');
end_datenum=datenum('04-Jun-2018 14:15:00'); 
end_datetime=datetime(end_datenum,'ConvertFrom','datenum');
total_duration=end_datetime-start_datetime; %total duration of the experiment, in datetime format
sample_duration= duration(0,15,0)'; %sample duration (should be 15 minutes)
sample_num=total_duration/sample_duration; %corresponding number of samples realized (should be odd since we start & end with background measurement)
s=zeros(sample_num,1);
e=zeros(sample_num,1);
start=start_datenum;
ends=addtodate(start_datenum,15,'minute');
% background loop (valve status=1)
for i=1:(sample_num/2)+1
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=1;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end
% sample loop (valve status =0)
start=addtodate(start_datenum,15,'minute');
ends=addtodate(start,15,'minute');
for i=1:sample_num/2
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=0;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end

% Run 52
start_datenum=datenum('04-Jun-2018 17:30:00');
start_datetime=datetime(start_datenum,'ConvertFrom','datenum');
end_datenum=datenum('04-Jun-2018 21:45:00'); 
end_datetime=datetime(end_datenum,'ConvertFrom','datenum');
total_duration=end_datetime-start_datetime; %total duration of the experiment, in datetime format
sample_duration= duration(0,15,0)'; %sample duration (should be 15 minutes)
sample_num=total_duration/sample_duration; %corresponding number of samples realized (should be odd since we start & end with background measurement)
s=zeros(sample_num,1);
e=zeros(sample_num,1);
start=start_datenum;
ends=addtodate(start_datenum,15,'minute');
% background loop (valve status=1)
for i=1:(sample_num/2)+1
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=1;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end
% sample loop (valve status =0)
start=addtodate(start_datenum,15,'minute');
ends=addtodate(start,15,'minute');
for i=1:sample_num/2
    s(i)= find_time(data(:,2),start);
    e(i)= find_time(data(:,2),ends);
    data(s(i):e(i),71)=0;
    start=addtodate(start,30,'minute');
    ends= addtodate(ends,30,'minute');
end


%% Save the data
filename=strcat(outputDir,'\data_concentration_updated');
save(filename,'data');

%% Figures
data_concentration=data;
for x=[1,2,26,27,28,29,30,51,52]
    figure('units','normalized','outerposition',[0 0 1 1])
    plot(datetime(data_concentration(data_concentration(:,1)==x,2),'Convertfrom','datenum'),data_concentration(data_concentration(:,1)==x,3),'.','MarkerSize',10,'Color',[ 0    0.4470    0.7410]);
    hold on
    plot(datetime(data_concentration(data_concentration(:,1)==x,2),'Convertfrom','datenum'),data_concentration(data_concentration(:,1)==x,4),'.','MarkerSize',10,'Color',[ 0.8500    0.3250    0.0980]);
    plot(datetime(data_concentration(data_concentration(:,1)==x,2),'Convertfrom','datenum'),data_concentration(data_concentration(:,1)==x,5),'.','MarkerSize',10,'Color',[ 0.9290    0.6940    0.1250]);
    plot(datetime(data_concentration(data_concentration(:,1)==x,2),'Convertfrom','datenum'),data_concentration(data_concentration(:,1)==x,6),'.','MarkerSize',10,'Color',[ 0.4940    0.1840    0.5560]);  
    set(gca, 'YScale', 'log')
    ylabel('OPC conc (std #/L','FontSize',15,'FontWeight','bold');
    yyaxis right
    plot(datetime(data_concentration(data_concentration(:,1)==x,2),'Convertfrom','datenum'),data_concentration(data_concentration(:,1)==x,71),'--','Color','black','LineWidth',2); 
    legend({'0.3-1um','1-3um','3-5um','>5um','Valve status'},'FontSize',12);
    
    run=string(x);
    filename=[outputDir '\data_run_' run];
    filename=strcat(filename(1,1),filename(1,2),filename(1,3));
    savefig(filename);
    
    filename=[outputDir '\data_run_' run '.png'];
    filename=strcat(filename(1,1),filename(1,2),filename(1,3),filename(1,4));
    saveas(gcf,filename)
end
end 
