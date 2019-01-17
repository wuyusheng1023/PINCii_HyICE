
%% this is the entrance code to process HyICE PINCii data
% v0.1, 2018-11-13, Yusheng Wu, made 
%
% principles
%     modular programming
%     functional isolation between modules
%     as many parameters as possible as input or output to functions
% 
% notes to code contributors:
%     please write clear comments with your code.
%     keep all version and modified history information.

%%
clear;
clc;

current_folder = cd;

% all other related codes of .m files put in to this 'm_code' folder
% load all .m files in the 'm_code'
addpath('./codes');

%% step 0:
% put all raw data into a same folder
% 
% folder: './00_raw_data'. 
% 
% raw data 3 types of files:
%     1. OPC_data: data from laptop txt files
%     2. cRIO_data: data copied from cRIO  files.temperatures, valve, dew point ...
%     3. experimental_notes: maybe excel or txt files with the start and end time of each run

%% step 1:
% This code should be used to load raw data into Matlab
% Outputs will be saved in the folder: './01_load_raw_data'
% 
% Description:
% function [OPC_data,cRIO_data,OPC_ColumnHeaders,cRIO_ColumnHeaders] = load_raw_data(inputDir,outputDir)
%     input: 
%         inputDir: path of all raw data files, './00_raw_data'
%         outputDir: folder path to save figures and middle data
%     output:
%         OPC_data: one matrix contain all OPC raw data
%         cRIO_data: one matrix contain all cRIO raw data
%         OPC_ColumnHeaders & cRIO_ColumnHeaders: one cell contain all the column headers names
%         
% what should be done in this function:
%     load all OPC and cRIO raw data and combine them together into two files
%     time is changed to UTC for both OPC and cRIO data
%     Duplicates are removed for both datasets
%     Datasets are sorted by time ascendingly
%     Empty data from cRIO is removed (NB: this might need to be changed in the future)

cd  = current_folder;
inputDir = [cd, '/00_raw_data'];
outputDir = [cd, '/01_load_raw_data'];
[OPC_data,cRIO_data,OPC_ColumnHeaders,cRIO_ColumnHeaders] = load_raw_data(inputDir,outputDir);

%% step 2:
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

cd  = current_folder;
inputDir = [cd, '/01_load_raw_data'];
outputDir = [cd, '/02_fix_time_shift'];
excelDir= cd;
[OPC_data_shifted, OPC_ColumnHeaders] = fix_time_shift(inputDir,excelDir,outputDir);

%% step 3:
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

cd  = current_folder;
inputDirOPC = [cd, '/02_fix_time_shift'];
inputDircRIO = [cd, '/01_load_raw_data'];
outputDir = [cd, '/03_combine_data'];
excelDir= cd;
[data, ColumnHeaders] = combine_data(inputDirOPC, inputDircRIO, outputDir,excelDir);

%% step 4
% convert OPC counts data to standard #/L
% 
% folder: './04_raw_number_concentration'
% 
% fuction [data, dataColumnHeaders] = raw_number_concentration(dir,data, dataColumnHeaders, roomTemp)
%     input:
%         dir: folder path to save figures and middle data
%         data: output of last step. data matrix. 
%         dataColumnHeaders: output of last step. data column names
%         roomTemp: (degree Celsius) room temperature. 20 degree Celsius
%     output:
%         data: matrix data in standard #/L
%         dataColumnHeaders: start_time, end_time, INP, valve, run_number
% 
% what should be done in this function:
%     OPC data * 12 = #/L data
%     using the factor (273+roomTemp)/273 to give standard #/L
%     plot figures by run to show data before and after convertion
%     backup outputs matrix and cell to a .mat file

cd  = current_folder;
inputDir = [cd, '/03_combine_data'];
outputDir = [cd, '/04_raw_number_concentration'];
roomTemp=25;
[data_concentration,ColumnHeaders] = raw_number_concentration(inputDir, outputDir,roomTemp);

%% step 5 :
% add valve number 
% additional step used for HyICE2018 campaign
% function [data_concentration_updated] = add_valve_status(inputDir, outputDir)
%    function used to add valve status for the 22nd and 23rd of April 2018
%    + 14th and 15th of May 2018
%    + 4th of June 2018
%    New file is named data_concentration_updated
cd  = current_folder;
inputDir = [cd, '/04_raw_number_concentration'];
outputDir = [cd, '/04_raw_number_concentration'];
[data_concentration_updated] = add_valve_status(inputDir, outputDir);


%% step 6:
% get average data for each measurement status (background/ambient, by valve)
%
% folder: './04_average_number_concentration'
% 
% fuction [data, dataColumnHeaders] = average_number_concentration(dir,data, dataColumnHeaders, beginFlushTime, endFlushTime)
%     input:
%         dir: folder path to save figures and middle data
%         data: output of last step. data matrix. 
%         dataColumnHeaders: output of last step. data column names
%         beginFlushTime: (sec.) 20 second as flush time after valve action
%         endFlushTime: (sec.) 10 second as flush time before valve action
%     output:
%         data: matrix data after the time shift fixed
%         dataColumnHeaders: start_time, end_time, INP, valve, run_number
% 
% what should be done in this function:
%     average data for each measurement status after substract flush time data
%     plot figures by run, averaged data and valve status should be included
%     backup outputs matrix and cell to a .mat file
%
% notes:
%     output start_time of every averageed measurement statue should add 20 second flushtime
%     output end_time of every averageed measurement statue should substract 10 second flushtime

cd  = current_folder;
dir = [cd, '/05_average_number_concentration'];
data_concentration_updated = [cd, '/04_raw_number_concentration/data_concentration_updated.mat'];
dataColumnHeaders = [cd, '/04_raw_number_concentration/ColumnHeaders.mat'];
beginFlushTime = 20;
endFlushTime = 10;

[data, dataColumnHeaders] = average_number_concentration(dir, data_concentration_updated, ...
    dataColumnHeaders, beginFlushTime, endFlushTime);

%% step 7:
% substract background signal from ambient data
% 
% folder: './05_offset_correction_INP'
% 
% fuction [data, dataColumnHeaders] = offset_correction_INP(dir,data, dataColumnHeaders, threshold)
%     input:
%         dir: folder path to save figures and middle data
%         data: output of last step. data matrix. 
%         dataColumnHeaders: ou tput of last step. data column names
%         threshold: (#/L) 5 #/L backgroud signal as threshold
%     output:
%         data: matrix data after the time shift fixed
%         dataColumnHeaders: start_time, end_time, INP, bkg_SD, run_number
%         mulply by 10 gives ambient data
% 
% what should be done in this function:
%     delele all data after background larger then threshold for each run
%     average neighboring background data and synchronise to ambient data
%     add one column of background standard deviation to output for future calculation of system uncertainty
%     plot figures by run to show data before and after offset correction, also background data
%     backup outputs matrix and cell to a .mat file

cd  = current_folder;
dir = [cd, '/06_offset_correction_INP'];
data = [cd, '/05_average_number_concentration/data.mat'];
dataColumnHeaders = [cd, '/05_average_number_concentration/dataColumnHeaders.mat'];
threshold = 10; % inside the chamber

[data, dataColumnHeaders] = offset_correction_INP(dir, data, dataColumnHeaders, threshold);

%% step 8:
% calculate the system uncertainty
%
% folder: './06_INP_uncertainty'
% 
% function [data, dataColumnHeaders] = INP_uncertainty(dir, data, dataColumnHeaders, flowUncertainty, OPCUncertainty)
%     input:
%         dir: folder path to save figures and middle data
%         data: output of last step. data matrix. 
%         dataColumnHeaders: output of last step. data column names
%         flowUncertainty: use 0.02 this time (2%)
%         OPCUncertainty: to be decide
%     output:
%         data: matrix data after the time shift fixed
%         dataColumnHeaders: start_time, end_time, INP, uncertainty, run_number
% 
% what should be done in this function:
%     calculate the system uncertainty with formula: flowUncertainty + bkg_SD + OPCUncertainty
%     data finalized
%     plot figures by run, with uncertainties
%     save outputs matrix and cell to a .mat file

cd  = current_folder;
dir = [cd, '/07_INP_uncertainty'];
data = [cd, '/06_offset_correction_INP/data.mat'];
dataColumnHeaders = [cd, '/06_offset_correction_INP/dataColumnHeaders.mat'];
flowUncertainty = 0.02;
OPCUncertainty = 0;

[data, dataColumnHeaders] = INP_uncertainty(dir, data, dataColumnHeaders, flowUncertainty, OPCUncertainty);

%% Step 9: Time series
% function used to plot the whole time serie
% /!!\ This function can/should be customized for each campaign
%
% function [data, dataColumnHeaders] = time_series(inputDir, outputDir, invalidruns)
%   input:
%           inputDir: folder with the last step data
%           outputDir: folder to save the new data and plots
%           invalidruns: run numbers with invalid data (ex: for the HyICE2018 campaign, invalidruns=40,49,50,51,63)
%   output:
%           data: matrix data after adding the half_time
%           dataColumnHeaders: 'start_time(UTC)','end_time(UTC)','half_time(UTC)','INP','Uncertainty','Run number'
%
%  What should be done in this function:
%   - remove invalid data: in the diary, some days are noted as 'weird' and
%     the data should be removed; 
%   - Replace negative values of INP concentration by 'NaN' values
%   - Calculate the 'half_time': the time used to display the data (mean between start and end time)
%   - plot the finale time serie
%   - save the final data

cd  = current_folder;
inputDir=[cd, '/07_INP_uncertainty'];
outputDir=[cd, '/08_time_series'];
invalidruns=[40,49,50,51,63];
[data, dataColumnHeaders] = time_series(inputDir, outputDir, invalidruns);


