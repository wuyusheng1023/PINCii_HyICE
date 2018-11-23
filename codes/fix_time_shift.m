 
function [OPC_data_shifted] = fix_time_shift(inputDir,outputDir)
%% This is the code for step 2 to process HyICE PINCii data
% This code should fix time difference between OPC and cRIO, data combine to one matrix
% Outputs will be saved in the folder: './02_fix_time_shift'
%
% Description:
% function [data, dataColumnHeaders] = fix_time_shift(dir,OPC_data, cRIO_data, dataColumnHeaders, time_shift)
%     input:
%         dir: folder path to save figures and middle data
%         OPC_data: output of last step. OPC data matrix. 
%         cRIO_data: output of last step. OPC data matrix. 
%         dataColumnHeaders: output of last step. data column names
%         time_shift: some excel of text file?
%     output:
%         data: matrix data after the time shift fixed
%         dataColumnHeaders: start_time, end_time, OPC, valve, run_number
%         
% what should be done in this function:
%     fix the time shift problem
%     plot figures by run to show the effect of time shift correction
%     only keep useful columns for future step as output. columns: start_time, end_time, OPC, valve, run_number
%     backup outputs matrix and cell to a .mat file

%% Load the data
FileName   = 'OPC_data.mat';
File       = fullfile(inputDir, FileName);
OPC_data=load(File); %struct
OPC_data= OPC_data.OPC_data ; %table 

%% Fix the time shift
% Convert OPC datenum time to datetime (just to see real times)
t = datetime(OPC_data(:,1),'ConvertFrom','datenum');

% Add 0, 10, 15, 20, 25, 35 or 50 secs
TimeShift_0 = t([1:136697],1)+0./86400; %{'06-May-2018 21:45:00'}
TimeShift_10 = t([136698:149131],1)+10./86400 ; %{'06-May-2018 21:45:00'}  to   09-May-2018 06:45:02
TimeShift_15 = t([149132:179495],1)+15./86400 ; %09-May-2018 06:45:02  to   {'10-May-2018 03:15:00'}
TimeShift_20 = t([179496:224302],1)+20./86400 ; %{'10-May-2018 03:15:00'}  to   {'11-May-2018 20:15:01'}
TimeShift_25 = t([224303:337830],1)+25./86400 ; %{'11-May-2018 20:15:01'}  to   {'18-May-2018 15:45:01'}
TimeShift_35 = t([337831:384386],1)+35./86400 ; %{'18-May-2018 15:45:01'}  to   {'27-May-2018 17:15:03'} 
TimeShift_50 = t([384387:591661],1)+50./86400 ; %{'27-May-2018 17:15:03'}  to   {'10-Jun-2018 10:38:30'} end

%Make a new array with shifted times
t_shifted = [TimeShift_0 ; TimeShift_10 ; TimeShift_15 ; TimeShift_20 ; TimeShift_25 ; TimeShift_35 ; TimeShift_50];

%Convert new array to datenum
t_shifted_datenum = datenum(t_shifted);

%Create new OPC_data_shifted table
OPC_data_shifted = [t_shifted_datenum OPC_data(:,2:6)];

%% Save the data
filename=strcat(outputDir,'\OPC_data_shifted');
save(filename,'OPC_data_shifted');
end 