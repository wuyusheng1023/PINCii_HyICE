function [OPC_data,cRIO_data,ColumnHeaders] = load_raw_data(inputDir,outputDir)
%% This is the code for step 1 to process HyICE PINCii data
% This code should be used to load raw data into Matlab
% Outputs will be saved in the folder: './01_load_raw_data'
% 
% Description:
% function [OPC_data, cRIO_data, dataColumnHeaders] = load_raw_data(inputDir, outputDir)
%     input: 
%         inputDir: path of all raw data files, './00_raw_data'
%         outputDir: folder path to save figures and middle data
%     output:
%         OPC_data: one matrix contain all OPC raw data
%         cRIO_data: one matrix contain all cRIO raw data
%         dataColumnHeaders: one cell contain all the column headers names
%         
% what should be done in this function:
%     load all OPC and cRIO raw data and combine them together into two files

%% Load all raw data

%%%%%%%%%%%%%%%%%
% Load OPC data %
%%%%%%%%%%%%%%%%%
FileList=dir(fullfile(inputDir,'**','*OPC*'))
% Load data from each txt file containing OPC data
for i=1:numel(FileList)
    fid=fopen(strcat(FileList(i).folder,'\',FileList(i).name));
    rawOPCdata{i}=textscan(fid,'%{dd/MM/uuuu}D%D%f%f%f%f%f','HeaderLines', 1 ,'CollectOutput', 1);
    fclose(fid);
end
% Save all OPC data into one matrix 
% Change time format to in Matlab format
% Save matrix as .mat file
OPC_data=[];
for i=1:numel(FileList)
    day=datestr(rawOPCdata{1,i}{1,1},'dd/mm/yyyy');
    time=datestr(rawOPCdata{1,i}{1,2},'HH:MM:SS');
    DateTime = strcat(day, {' '}, time);
    Date=datetime(DateTime,'inputformat','dd/MM/yyyy HH:mm:ss');
    data=datenum(Date);
    OPC_data=[OPC_data;data rawOPCdata{1,i}{1,3}];
end 
filename=strcat(outputDir,'\OPC_data');
save(filename,'OPC_data');

%%%%%%%%%%%%%%%%%%
% Load cRIO data %
%%%%%%%%%%%%%%%%%%
FileList=dir(fullfile(inputDir,'**','*test.tdms'))
% Convert each file using the function convertTDMS and load the converted data
for i=1:numel(FileList)
    ConvertedData{i}=convertTDMS(0,strcat(FileList(i).folder,'\',FileList(i).name));
end
% Save all data into one matrix
cRIO_data=[];
for i=3:numel(FileList) %%% for loop should not include the 22nd and 23rd of April because the Labview program was then different
    cRIO_time=ConvertedData{1,i}.Data.MeasuredData(3).Data;               % time
    time=cRIO_time/86400+datenum([1904 1 1 0 0 0]);                       % UTC time
    SP_inner_wall=ConvertedData{1,i}.Data.MeasuredData(4).Data;           % SP Inner
    SP_outer_wall=ConvertedData{1,i}.Data.MeasuredData(5).Data;           % SP Outer
    SP_evap=ConvertedData{1,i}.Data.MeasuredData(6).Data;                 % SP Evap
    TC1_0=ConvertedData{1,i}.Data.MeasuredData(7).Data;                   % TC1_0
    TC1_1=ConvertedData{1,i}.Data.MeasuredData(8).Data;                   % TC1_1
    TC1_2=ConvertedData{1,i}.Data.MeasuredData(9).Data;                   % TC1_2
    TC1_3=ConvertedData{1,i}.Data.MeasuredData(10).Data;                  % TC1_3
    TC1_4=ConvertedData{1,i}.Data.MeasuredData(11).Data;                  % TC1_4
    TC1_5=ConvertedData{1,i}.Data.MeasuredData(12).Data;                  % TC1_5
    TC1_6=ConvertedData{1,i}.Data.MeasuredData(13).Data;                  % TC1_6
    TC1_7=ConvertedData{1,i}.Data.MeasuredData(14).Data;                  % TC1_7
    TC1_8=ConvertedData{1,i}.Data.MeasuredData(15).Data;                  % TC1_8
    TC1_9=ConvertedData{1,i}.Data.MeasuredData(16).Data;                  % TC1_9
    TC1_10=ConvertedData{1,i}.Data.MeasuredData(17).Data;                 % TC1_10
    TC1_11=ConvertedData{1,i}.Data.MeasuredData(18).Data;                 % TC1_11
    TC1_12=ConvertedData{1,i}.Data.MeasuredData(19).Data;                 % TC1_12
    TC1_13=ConvertedData{1,i}.Data.MeasuredData(20).Data;                 % TC1_13
    TC1_14=ConvertedData{1,i}.Data.MeasuredData(21).Data;                 % TC1_14
    TC1_15=ConvertedData{1,i}.Data.MeasuredData(22).Data;                 % TC1_15
    TC1 = [TC1_0 TC1_1 TC1_2 TC1_3 TC1_4 TC1_5 TC1_6 TC1_7 TC1_8 TC1_9 TC1_10 TC1_11 TC1_12 TC1_13 TC1_14 TC1_15];
    TC2_0=ConvertedData{1,i}.Data.MeasuredData(23).Data;                  % TC2_0
    TC2_1=ConvertedData{1,i}.Data.MeasuredData(24).Data;                  % TC2_1
    TC2_2=ConvertedData{1,i}.Data.MeasuredData(25).Data;                  % TC2_2
    TC2_3=ConvertedData{1,i}.Data.MeasuredData(26).Data;                  % TC2_3
    TC2_4=ConvertedData{1,i}.Data.MeasuredData(27).Data;                  % TC2_4
    TC2_5=ConvertedData{1,i}.Data.MeasuredData(28).Data;                  % TC2_5
    TC2_6=ConvertedData{1,i}.Data.MeasuredData(29).Data;                  % TC2_6
    TC2_7=ConvertedData{1,i}.Data.MeasuredData(30).Data;                  % TC2_7
    TC2_8=ConvertedData{1,i}.Data.MeasuredData(31).Data;                  % TC2_8
    TC2_9=ConvertedData{1,i}.Data.MeasuredData(32).Data;                  % TC2_9
    TC2_10=ConvertedData{1,i}.Data.MeasuredData(33).Data;                 % TC2_10
    TC2_11=ConvertedData{1,i}.Data.MeasuredData(34).Data;                 % TC2_11
    TC2_12=ConvertedData{1,i}.Data.MeasuredData(35).Data;                 % TC2_12
    TC2_13=ConvertedData{1,i}.Data.MeasuredData(36).Data;                 % TC2_13
    TC2_14=ConvertedData{1,i}.Data.MeasuredData(37).Data;                 % TC2_14
    TC2_15=ConvertedData{1,i}.Data.MeasuredData(38).Data;                 % TC2_15
    TC2 = [TC2_0 TC2_1 TC2_2 TC2_3 TC2_4 TC2_5 TC2_6 TC2_7 TC2_8 TC2_9 TC2_10 TC2_11 TC2_12 TC2_13 TC2_14 TC2_15];
    TC3_0=ConvertedData{1,i}.Data.MeasuredData(39).Data;                  % TC3_0
    TC3_1=ConvertedData{1,i}.Data.MeasuredData(40).Data;                  % TC3_1
    TC3_2=ConvertedData{1,i}.Data.MeasuredData(41).Data;                  % TC3_2
    TC3_3=ConvertedData{1,i}.Data.MeasuredData(42).Data;                  % TC3_3
    TC3_4=ConvertedData{1,i}.Data.MeasuredData(43).Data;                  % TC3_4
    TC3_5=ConvertedData{1,i}.Data.MeasuredData(44).Data;                  % TC3_5
    TC3_6=ConvertedData{1,i}.Data.MeasuredData(45).Data;                  % TC3_6
    TC3_7=ConvertedData{1,i}.Data.MeasuredData(46).Data;                  % TC3_7
    TC3_8=ConvertedData{1,i}.Data.MeasuredData(47).Data;                  % TC3_8
    TC3_9=ConvertedData{1,i}.Data.MeasuredData(48).Data;                  % TC3_9
    TC3_10=ConvertedData{1,i}.Data.MeasuredData(49).Data;                 % TC3_10
    TC3_11=ConvertedData{1,i}.Data.MeasuredData(50).Data;                 % TC3_11
    TC3_12=ConvertedData{1,i}.Data.MeasuredData(51).Data;                 % TC3_12
    TC3_13=ConvertedData{1,i}.Data.MeasuredData(52).Data;                 % TC3_13
    TC3_14=ConvertedData{1,i}.Data.MeasuredData(53).Data;                 % TC3_14
    TC3_15=ConvertedData{1,i}.Data.MeasuredData(54).Data;                 % TC3_15
    TC3 = [TC3_0 TC3_1 TC3_2 TC3_3 TC3_4 TC3_5 TC3_6 TC3_7 TC3_8 TC3_9 TC3_10 TC3_11 TC3_12 TC3_13 TC3_14 TC3_15];
    TC4_0=ConvertedData{1,i}.Data.MeasuredData(55).Data;                  % TC4_0
    TC4_1=ConvertedData{1,i}.Data.MeasuredData(56).Data;                  % TC4_1
    TC4_2=ConvertedData{1,i}.Data.MeasuredData(57).Data;                  % TC4_2
    TC4_3=ConvertedData{1,i}.Data.MeasuredData(58).Data;                  % TC4_3
    TC4_4=ConvertedData{1,i}.Data.MeasuredData(59).Data;                  % TC4_4
    TC4_5=ConvertedData{1,i}.Data.MeasuredData(60).Data;                  % TC4_5
    TC4_6=ConvertedData{1,i}.Data.MeasuredData(61).Data;                  % TC4_6
    TC4_7=ConvertedData{1,i}.Data.MeasuredData(62).Data;                  % TC4_7
    TC4_8=ConvertedData{1,i}.Data.MeasuredData(63).Data;                  % TC4_8
    TC4_9=ConvertedData{1,i}.Data.MeasuredData(64).Data;                  % TC4_9
    TC4_10=ConvertedData{1,i}.Data.MeasuredData(65).Data;                 % TC4_10
    TC4_11=ConvertedData{1,i}.Data.MeasuredData(66).Data;                 % TC4_11
    TC4_12=ConvertedData{1,i}.Data.MeasuredData(67).Data;                 % TC4_12
    TC4_13=ConvertedData{1,i}.Data.MeasuredData(68).Data;                 % TC4_13
    TC4_14=ConvertedData{1,i}.Data.MeasuredData(69).Data;                 % TC4_14
    TC4_15=ConvertedData{1,i}.Data.MeasuredData(70).Data;                 % TC4_15
    TC4 = [TC4_0 TC4_1 TC4_2 TC4_3 TC4_4 TC4_5 TC4_6 TC4_7 TC4_8 TC4_9 TC4_10 TC4_11 TC4_12 TC4_13 TC4_14 TC4_15];
    Water_level=ConvertedData{1,i}.Data.MeasuredData(71).Data;            % Water level
    Chamber_pres=ConvertedData{1,i}.Data.MeasuredData(72).Data;           % Chamber pressure
    Sheath_dew_pt=ConvertedData{1,i}.Data.MeasuredData(73).Data;          % Sheath Flow dew point
    background_valve=ConvertedData{1,i}.Data.MeasuredData(74).Data;       % Background valve status
    
    cRIO_data=[cRIO_data; time SP_inner_wall SP_outer_wall SP_evap TC1 TC2 TC3 TC4 Water_level Chamber_pres Sheath_dew_pt background_valve ];
end
% Delete empty data
index = cRIO_data(:,1) > datenum([1904 1 1 0 0 0]);
cRIO_data = cRIO_data(index,:);
cRIO_data(:,36)=[];  % TC not connected
cRIO_data(:,51)=[];  % TC not connected
cRIO_data(:,62)=[];  % TC not connected
cRIO_data(:,62)=[];  % TC not connected
cRIO_data(:,62)=[];  % TC not connected
cRIO_data(:,62)=[];  % TC not connected
cRIO_data(:,62)=[];  % TC not connected

% Save file
filename=strcat(outputDir,'\cRIO_data');
save(filename,'cRIO_data');
end 