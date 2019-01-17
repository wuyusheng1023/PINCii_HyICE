function [data, ColumnHeaders] = combine_data(inputDirOPC, inputDircRIO, outputDir,excelDir)
%% This is the code for step 3 to process HyICE PINCii data
% This code should be used to combine all the data together (OPC and cRIO)
% Outputs will be saved in the folder: './03_combine_data'
% 
% Description:
% function [data, ColumnHeaders] = combine_data(inputDirOPC, inputDircRIO, outputDir)
%     input: 
%         inputDirOPC: path of OPC file (after fixing time shift)
%         inputDircRIO: path of cRIO file
%         outputDir: folder path to save figures and middle data
%     output:
%         data: matrix containing all OPC and cRIO data
%         
% This function:
%     loads all raw data and combines them together
%     creates a new column for run number, dozens runs in all
%     plots raw data by run for check. figure includ: OPC reading, temperatuers, valve ...
% 
% notes:
%     the time of OPC file is the end time of every 5 seconds.
%     the time of cRIO is the exactly the sampling time.

%% Load the data
FileName   = 'OPC_data_shifted.mat';
OPC_data_shifted=load(fullfile(inputDirOPC,FileName)); %struct
OPC_data_shifted= OPC_data_shifted.OPC_data_shifted ; %table 

FileName1 = 'cRIO_data.mat';
cRIO_data=load(fullfile(inputDircRIO,FileName1)); %struct
cRIO_data=cRIO_data.cRIO_data; % table


%% Combine all data 
data=[];
data(:,1:6)=OPC_data_shifted(:,1:6);
size_cRIO_data=size(cRIO_data);
for i=1:(size_cRIO_data(2)-1)
    a=6+i; % 6 is the number of column in OPC_data_shifted
    b=1+i;
    data(:,a)=interp1(cRIO_data(:,1),cRIO_data(:,b),data(:,1),'Linear');
end


%% Create the run index
% Load the excel file with the time shift
FileName = 'time_shift.xlsx';
File= fullfile(excelDir, FileName);
Runs = readtable(File);
% Set starting and ending points automatically
Runs = [Runs(:,1) Runs(:,2) Runs(:,3) Runs(:,4)];
Start_time = datenum(table2array(Runs(:,2)));
End_time = datenum(table2array(Runs(:,3)));
Time_shift = table2array(Runs(:,4));

%% Read and load excel data with run starting & ending times
n=length(Start_time);
Runs_matrix=zeros(n,6);
m=1;
for x = [1:n];
[start index_start] = min(abs(data(:,1)-Start_time(x))); %Find the closest time values in the first column (time) of the data_concentration tabl
[finnish index_end] = min(abs(data(:,1)-End_time(x)));
Runs_matrix(m,1)=x; % Store run number
Runs_matrix(m,2)=index_start; % Store position of starting point 
Runs_matrix(m,3)=index_end; % Store position of ending point
Runs_matrix(m,4)=data(index_start,1); % Store position of ending point
Runs_matrix(m,5)=data(index_end,1); % Store position of ending point
m=m+1;
end
Runs_matrix(:,6) = Time_shift;

%% Add run number to the dataset (first column)
% Run number 0 means it is not a run
ni=length(data);
runum=zeros(ni,1);
for x = [1:n]
    for i=Runs_matrix(x,2):Runs_matrix(x,3)
        runum(i)=x;
    end
end
data = [runum , data];


%% Save the data
filename=strcat(outputDir,'\data');
save(filename,'data');

%% Create  column headers 
ColumnHeaders={'Run number','DateTime (UTC)','Ch1 (0.3-1um)','Ch2 (1-3um)','Ch3 (3-5um)','Ch4 (>5um)','Backlight','Set Point Inner Wall','Set Point Outer Wall','Set Point Evap','TC1_0', 'TC1_1', 'TC1_2', 'TC1_3', 'TC1_4', 'TC1_5', 'TC1_6', 'TC1_7', 'TC1_8', 'TC1_9', 'TC1_10', 'TC1_11', 'TC1_12', 'TC1_13', 'TC1_14', 'TC1_15','TC2_0', 'TC2_1', 'TC2_2', 'TC2_3', 'TC2_4', 'TC2_5', 'TC2_6', 'TC2_7', 'TC2_8', 'TC2_9', 'TC2_10', 'TC2_11', 'TC2_12', 'TC2_13', 'TC2_14','TC3_0', 'TC3_1', 'TC3_2', 'TC3_3', 'TC3_4', 'TC3_5', 'TC3_6', 'TC3_7', 'TC3_8', 'TC3_9', 'TC3_10', 'TC3_11', 'TC3_12', 'TC3_13', 'TC3_14','TC4_0', 'TC4_1', 'TC4_2', 'TC4_3', 'TC4_4', 'TC4_5', 'TC4_6', 'TC4_7', 'TC4_8', 'TC4_9', 'TC4_10','Water level','Chamber pressure','Sheath Flow dew point','Background valve status'};
save([outputDir, '/ColumnHeaders.mat'], 'ColumnHeaders') ;

%% Plot the data

for x = [1:n]
    figure('units','normalized','outerposition',[0 0 1 1])
    plot(datetime(data(Runs_matrix(x,2):Runs_matrix(x,3),2),'Convertfrom','datenum'),data(Runs_matrix(x,2):Runs_matrix(x,3),3),'.','MarkerSize',10,'Color',[ 0    0.4470    0.7410]);
    hold on
    plot(datetime(data(Runs_matrix(x,2):Runs_matrix(x,3),2),'Convertfrom','datenum'),data(Runs_matrix(x,2):Runs_matrix(x,3),4),'.','MarkerSize',10,'Color',[ 0.8500    0.3250    0.0980]);
    plot(datetime(data(Runs_matrix(x,2):Runs_matrix(x,3),2),'Convertfrom','datenum'),data(Runs_matrix(x,2):Runs_matrix(x,3),5),'.','MarkerSize',10,'Color',[ 0.9290    0.6940    0.1250]);
    plot(datetime(data(Runs_matrix(x,2):Runs_matrix(x,3),2),'Convertfrom','datenum'),data(Runs_matrix(x,2):Runs_matrix(x,3),6),'.','MarkerSize',10,'Color',[ 0.4940    0.1840    0.5560]);
    set(gca, 'YScale', 'log')
    ylabel('OPC counts (#/5sec)','FontSize',15,'FontWeight','bold');
    yyaxis right
    plot(datetime(data(Runs_matrix(x,2):Runs_matrix(x,3),2),'Convertfrom','datenum'),data(Runs_matrix(x,2):Runs_matrix(x,3),71),'--','Color','black','LineWidth',2);
    legend({'0.3-1um','1-3um','3-5um','>5um','Valve status'},'FontSize',12);
    
    run=string(x);
    filename=[outputDir '\data_run_' run];
    filename=strcat(filename(1,1),filename(1,2),filename(1,3));
    savefig(filename);
    
    filename=[outputDir '\data_run_' run '.png'];
    filename=strcat(filename(1,1),filename(1,2),filename(1,3),filename(1,4));
    saveas(gcf,filename)
    close;
end

end 
