clear;
clc;

%% This code tests the function load_raw_data

inputDir='C:\Users\mittaaja\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\00_raw_data';
outputDir='C:\Users\mittaaja\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\01_load_raw_data';
res=load_raw_data(inputDir,outputDir);

%% This part tests the function fix_time_shift
inputDir='C:\Users\mittaaja\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\01_load_raw_data';
outputDir='C:\Users\mittaaja\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\02_fix_time_shift';
fix_time_shift(inputDir,outputDir);

%% This part tests the function combine_data
inputDirOPC='C:\Users\mittaaja\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\02_fix_time_shift';
inputDircRIO='C:\Users\mittaaja\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\01_load_raw_data';
outputDir='C:\Users\mittaaja\Desktop\PINCII\Matlab_codes\Common_code\PINCii_HyICE\03_combine_data';
