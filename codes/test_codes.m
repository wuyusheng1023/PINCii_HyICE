clear;
clc;

%% This code tests the function load_raw_data

inputDir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\00_raw_data';
outputDir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\01_load_raw_data';
res=load_raw_data(inputDir,outputDir);

%% This part tests the function fix_time_shift
inputDir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\01_load_raw_data';
excelDir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE';
outputDir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\02_fix_time_shift';
fix_time_shift(inputDir,outputDir);

%% This part tests the function combine_data
inputDirOPC='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\02_fix_time_shift';
inputDircRIO='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\01_load_raw_data';
excelDir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE';
outputDir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\03_combine_data';

%% This part tests the function raw_number_concentration
inputDir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\03_combine_data';
outputDir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\03bis_raw_number_concentration';
roomTemp=25;
res=raw_number_concentration(inputDir, outputDir,roomTemp);

%% This part tests the function average_number_concentration
FileName   = 'data_concentration.mat';
inputDir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\03bis_raw_number_concentration';
data=fullfile(inputDir,FileName); 
dir='C:\Users\brasseur\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\04_average_number_concentration\New folder';
beginFlushTime=20;
endFlushTime=10;
res=average_number_concentration(dir, data, beginFlushTime, endFlushTime)