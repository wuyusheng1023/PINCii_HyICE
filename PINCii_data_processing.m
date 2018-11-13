
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
addpath('./m_code');

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
% load raw data into Matlab
% 
% folder: './01_load_raw_data'
% 
% fuction [OPC_data, cRIO_data, dataColumnHeaders] = load_raw_data(inputDir, outputDir)
%     input: 
%         inputDir: path of all raw data files, './00_raw_data'
%         outputDir: folder path to save figures and middle data
%     output:
%         OPC_data: one matrix contain all OPC raw data
%         cRIO_data: one matrix contain all cRIO raw data
%         dataColumnHeaders: one cell contain all the column headers names
%         
% what should be done in this function:
%     load all raw data and combine them together
%     delele duplicate rows
%     sort by time ascendingly
%     create a new column for run number, dozens runs in all
%     plot raw data by run for check. figure includ: OPC reading, temperatuers, valve ...
%     delete invalid data acording to experimental notes
%     backup outputs matrix and cell to a .mat file
% 
% notes:
%     the time of OPC file is the end time of every 5 seconds.
%     the time of cRIO is the exactly the sampling time.
    
%% step 2:
% fix time difference between OPC and cRIO, data combine to one matrix
% 
% folder: './02_fix_time_shift'
% 
% fuction [data, dataColumnHeaders] = fix_time_shift(dir,OPC_data, cRIO_data, dataColumnHeaders, time_shift)
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

%% step 3:
% convert OPC counts data to standard #/L
% 
% folder: './03_raw_number_concentration'
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

%% step 4:
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

%% step 5:
% substract background signal from ambient data
% 
% folder: './05_offset_correction_INP'
% 
% fuction [data, dataColumnHeaders] = offset_correction_INP(dir,data, dataColumnHeaders, threshold)
%     input:
%         dir: folder path to save figures and middle data
%         data: output of last step. data matrix. 
%         dataColumnHeaders: output of last step. data column names
%         threshold: (#/L) 5 #/L backgroud signal as threshold
%     output:
%         data: matrix data after the time shift fixed
%         dataColumnHeaders: start_time, end_time, INP, bkg_SD
% 
% what should be done in this function:
%     delele all data after background larger then threshold for each run
%     average neighboring background data and synchronise to ambient data
%     add one column of background standard deviation to output for future calculation of system uncertainty
%     plot figures by run to show data before and after offset correction, also background data
%     backup outputs matrix and cell to a .mat file

%% step 6:
% calculate the system uncertainty
%
% folder: './06_INP_uncertainty'
% 
% fuction [data, dataColumnHeaders] = INP_uncertainty(dir, data, dataColumnHeaders, flowUncertainty, OPCUncertainty)
%     input:
%         dir: folder path to save figures and middle data
%         data: output of last step. data matrix. 
%         dataColumnHeaders: output of last step. data column names
%         flowUncertainty: use 0.02 this time (2%)
%         OPCUncertainty: to be decide
%     output:
%         data: matrix data after the time shift fixed
%         dataColumnHeaders: start_time, end_time, INP, uncertainty
% 
% what should be done in this function:
%     calculate the system uncertainty with formula: flowUncertainty + bkg_SD + OPCUncertainty
%     data finalized
%     plot figures by run, with uncertainties
%     save outputs matrix and cell to a .mat file, also save final data as .csv or .txt file
