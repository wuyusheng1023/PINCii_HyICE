% step 3:
% convert OPC counts data to standard #/L
function [data_concentration,ColumnHeaders] = raw_number_concentration(inputDir, outputDir,roomTemp)

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

%% Load the data
FileName   = 'data.mat';
File       = fullfile(inputDir, FileName);
data = load(File); %struct
data = data.data ; %table 

%% Convert to #/L in the chamber
data_concentration_ch1=data(:,3).*6; %Convert Channel 1 #/sec to #/L in the outside air (.*10)
data_concentration_ch2=data(:,4).*6; %Convert Channel 1 #/sec to #/L in the outside air (.*10)
data_concentration_ch3=data(:,5).*6; %Convert Channel 1 #/sec to #/L in the outside air (.*10)
data_concentration_ch4=data(:,6).*6; %Convert Channel 1 #/sec to #/L in the outside air (.*10)

%% Convert to standard #/L in the chamber
data_concentration_ch1=data_concentration_ch1.*(273+roomTemp)/273; %Convert #/L to std #/L
data_concentration_ch2=data_concentration_ch2.*(273+roomTemp)/273; %Convert #/L to std #/L
data_concentration_ch3=data_concentration_ch3.*(273+roomTemp)/273; %Convert #/L to std #/L
data_concentration_ch4=data_concentration_ch4.*(273+roomTemp)/273; %Convert #/L to std #/L

%% Create data_concentration Table
data_concentration = [data(:,1) data(:,2) data_concentration_ch1 data_concentration_ch2 data_concentration_ch3 data_concentration_ch4 data(:,7:71)];


%% Save the data
filename=strcat(outputDir,'\data_concentration');
save(filename,'data_concentration');

%% Create  column headers 
ColumnHeaders={'Run number','DateTime (UTC)','Ch1 (std #/L)','Ch2 (std #/L)','Ch3 (std #/L)','Ch4 (std #/L)','Backlight','Set Point Inner Wall','Set Point Outer Wall','Set Point Evap','TC1_0', 'TC1_1', 'TC1_2', 'TC1_3', 'TC1_4', 'TC1_5', 'TC1_6', 'TC1_7', 'TC1_8', 'TC1_9', 'TC1_10', 'TC1_11', 'TC1_12', 'TC1_13', 'TC1_14', 'TC1_15','TC2_0', 'TC2_1', 'TC2_2', 'TC2_3', 'TC2_4', 'TC2_5', 'TC2_6', 'TC2_7', 'TC2_8', 'TC2_9', 'TC2_10', 'TC2_11', 'TC2_12', 'TC2_13', 'TC2_14','TC3_0', 'TC3_1', 'TC3_2', 'TC3_3', 'TC3_4', 'TC3_5', 'TC3_6', 'TC3_7', 'TC3_8', 'TC3_9', 'TC3_10', 'TC3_11', 'TC3_12', 'TC3_13', 'TC3_14','TC4_0', 'TC4_1', 'TC4_2', 'TC4_3', 'TC4_4', 'TC4_5', 'TC4_6', 'TC4_7', 'TC4_8', 'TC4_9', 'TC4_10','Water level','Chamber pressure','Sheath Flow dew point','Background valve status'};
save([outputDir, '/ColumnHeaders.mat'], 'ColumnHeaders') ;

%% Plot the data
n=max(data_concentration(:,1));
for x = [1:n]
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
    close;
end
end 



