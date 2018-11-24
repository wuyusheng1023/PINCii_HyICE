function [data] = combine_data(inputDirOPC, inputDircRIO, outputDir)
%% This is the code for step 3 to process HyICE PINCii data
% This code should be used to combine all the data together (OPC and cRIO)
% Outputs will be saved in the folder: './03_combine_data'
% 
% Description:
% function [data] = combine_data(inputDirOPC, inputDircRIO, outputDir)
%     input: 
%         inputDirOPC: path of OPC file (after fixing time shift)
%         inputDircRIO: path of cRIO file
%         outputDir: folder path to save figures and middle data
%     output:
%         data: matrix containing all OPC data and cRIO valve data
%         
% what should be done in this function:
%     load all raw data and combine them together
%     delete duplicate rows
%     sort by time ascendingly
%     create a new column for run number, dozens runs in all
%     plot raw data by run for check. figure includ: OPC reading, temperatuers, valve ...
%     delete invalid data acording to experimental notes
%     backup outputs matrix and cell to a .mat file
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

%% Remove duplicates
OPC_data_shifted=unique(OPC_data_shifted,'row');
cRIO_data=unique(cRIO_data,'row');

%% Combine all data 
data=[];
data(:,1:6)=OPC_data_shifted(:,1:6);
size_cRIO_data=size(cRIO_data);
for i=1:(size_cRIO_data(2)-1)
    a=6+i; % 6 is the number of column in OPC_data_shifted
    b=1+i;
    data(:,a)=interp1(cRIO_data(:,1),cRIO_data(:,b),data(:,1),'Linear');
end
filename=strcat(outputDir,'\data');
save(filename,'data');

%% Plot the data
%filename=strcat(outputDir,'\run_date.xlsx');
%info = xlsread(filename);
%start_dates=datenum(info(:,1:6));
%end_dates=datenum(info(:,7:12));

%for i=1:length(start_dates)
%    index = data_all(:,1)>=start_dates(i) & data_all(:,1)< end_dates(i);
%   
%    T_6 = plot(data_all(index,1),data_all(index,10));
%end


%% Combine only the OPC channel 4 data and the cRIO valve data
%data=[];
%data(:,1:6)=OPC_data_shifted(:,1:6);
%data(:,7)=interp1(cRIO_data(:,1),cRIO_data(:,65),data(:,1),'Linear');

end 
