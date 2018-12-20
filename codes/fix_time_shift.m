 
function [OPC_data_shifted, OPC_ColumnHeaders] = fix_time_shift(inputDir,excelDir,outputDir)
%% This is the code for step 2 to process HyICE PINCii data
% This code should fix time difference between OPC and cRIO computer
% Outputs will be saved in the folder: './02_fix_time_shift'
%
% Description:
% function [OPC_data_shifted, OPC_ColumnHeaders] = fix_time_shift(inputDir,excelDir,outputDir)
%     input:
%         outputDir: folder path to save figures and middle data
%         inputDir: folder of last step. with OPC data matrix.
%         excelDir: folder with the excel or text file containing the time_shift record
%     output:
%         data: matrix data after the time shift fixed
%         dataColumnHeaders: 'DateTime (UTC)','Ch1 (0.3-1um)','Ch2 (1-3um)','Ch3 (3-5um)','Ch4 (>5um)','Backlight'
%
% what should be done in this function:
%     fix the time shift problem
%     backup outputs matrix and cell to a .mat file
%      /!\ For now the time shift is corrected only for the data measured during the run time, not for the whole dataset (data measured during two different runs isn't corrected)

%% Load the data
FileName   = 'OPC_data.mat';
File       = fullfile(inputDir, FileName);
OPC_data=load(File); %struct
OPC_data= OPC_data.OPC_data ; %table

%% Load the excel file with the time shift
FileName = 'time_shift.xlsx';
File= fullfile(excelDir, FileName);
Runs = readtable(File);
Runs = [Runs(:,1) Runs(:,2) Runs(:,3) Runs(:,4)];
Start_time = datenum(table2array(Runs(:,2)));   % Start time of each run
End_time = datenum(table2array(Runs(:,3)));     % End time of each run
Time_shift = table2array(Runs(:,4));            % Time shift between OPC and cRIO computer for each run

%% Divide the whole datasets by runs (by creating an index)
n=length(Start_time);
Runs_matrix=zeros(n,6);
m=1;
for x = [1:n];
    [start index_start] = min(abs(OPC_data(:,1)-Start_time(x))); %Find the closest time values in the first column (time) of the data_concentration tabl
    [finnish index_end] = min(abs(OPC_data(:,1)-End_time(x)));
    
    Runs_matrix(m,1)=x; % Store run number
    Runs_matrix(m,2)=index_start; % Store position of starting point
    Runs_matrix(m,3)=index_end; % Store position of ending point
    Runs_matrix(m,4)=OPC_data(index_start,1); % Store position of ending point
    Runs_matrix(m,5)=OPC_data(index_end,1); % Store position of ending point
    
    m=m+1;
end
Runs_matrix(:,6) = Time_shift;

%% Fix time shift for the data measured during runs
m=1;
for x = [1:1:n];
    OPC_data(Runs_matrix(x,2):Runs_matrix(x,3),1) = OPC_data(Runs_matrix(x,2):Runs_matrix(x,3),1)+Runs_matrix(x,6)./86400 ;
    m=m+1;
end

OPC_data_shifted = OPC_data;
t_shifted = datetime(OPC_data_shifted(:,1),'ConvertFrom','datenum'); % To plot against real datetime


%% Save the data
filename=strcat(outputDir,'\OPC_data_shifted');
save(filename,'OPC_data_shifted');

%% Create OPC column headers 
OPC_ColumnHeaders={'DateTime (UTC)','Ch1 (0.3-1um)','Ch2 (1-3um)','Ch3 (3-5um)','Ch4 (>5um)','Backlight'};
save([outputDir, '/OPC_ColumnHeaders.mat'], 'OPC_ColumnHeaders') ;
end