function [data, dataColumnHeaders] = offset_correction_INP(dir, data, dataColumnHeaders, threshold)
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
%         dataColumnHeaders: start_time, end_time, INP, bkg_SD, run_number
% 
% what should be done in this function:
%     delele all data after background larger then threshold for each run
%     average neighboring background data and synchronise to ambient data
%     add one column of background standard deviation to output for future calculation of system uncertainty
%     plot figures by run to show data before and after offset correction, also background data
%     backup outputs matrix and cell to a .mat file

%% load data from last step

load(data);
load(dataColumnHeaders);

input_data = data; % backup input data for future use

%% remove data that larger than threshold

runs = unique(data(:,5)); % run numbers
valid_data = [];    % to receive data within threshold
for run = 1:length(runs) % do loop for average by run_number
    data_run = data(data(:,5)==runs(run),:);  % get each run data
    valid_bkg = find((data_run(:,4)==1)&(data_run(:,3)<threshold)); % valid background data pints
    if length(valid_bkg) >=2    % at least need 2 valid background pints for each run
        valid_data = [valid_data; data_run(valid_bkg(1):valid_bkg(end),:)];
    end
end

%% average neighboring background data and synchronise to ambient data
% add one column of background standard deviation to output for future calculation of system uncertainty

runs = unique(valid_data(:,5));  % run numbers
offset_data = [];   % to receive data after offset correction
for run = 1:length(runs) % do loop for average by run_number
    data_run = valid_data(valid_data(:,5)==runs(run),:);  % get each run data
    bkg = find(data_run(:,4)==1);   % background points
    offest = (data_run(bkg(1:end-1),3)+data_run(bkg(2:end),3))/2;   % calculate offset values
    bkg_SD = sqrt(abs(offest)); % square root of background as part of uncertainty
    ambient = find(data_run(:,4)==0);   % ambient points
    data_run(ambient,3) = data_run(ambient,3) - offest; % substract background
    offset_data = [offset_data; [data_run(ambient,1:3), bkg_SD, data_run(ambient,5)]];
end

%% plot figures by run

runs = unique(offset_data(:,5));  % run numbers
for run = 1:length(runs) % do loop for plot by run_number    
    % figure setting
    set(0,'Units','pixels')
    scnsize = get(0,'ScreenSize');
    pos1  = [scnsize(1) + 50 scnsize(2) + 50 scnsize(3) - 100 scnsize(4) - 100];
    figure('Position',pos1)
    
    % plot setting
    axes('Position', [0.1 0.1 0.8 0.8])
    set(gca,'FontSize',16,'FontName','helvetica','LineWidth',1)
    hold on
    
    % plot 5 sec. background
    index = input_data(:,5)==runs(run) & input_data(:,4)==1;
    x = (input_data(index,1)+input_data(index,2))/2;
    y = input_data(index,3);
    plot(x,y, 'go', 'MarkerSize', 12)
    datetick('x')
    
    % plot 5 sec. ambient
    index = input_data(:,5)==runs(run) & input_data(:,4)==0;
    x = (input_data(index,1)+input_data(index,2))/2;
    y = input_data(index,3);
    plot(x,y, 'mo','MarkerSize', 12)
    datetick('x')
    
    % plot offset correction data
    index = offset_data(:,5)==runs(run);
    x = (offset_data(index,1)+offset_data(index,2))/2;
    y = offset_data(index,3);
    plot(x,y, 'k*', 'MarkerSize', 20)
    datetick('x')
    
    title(['PINCii data, run number: ', num2str(runs(run)), ' start at: ', ...
        datestr(input_data(1,1))],'FontSize',16)
    ylabel('#/L','fontsize',14)
    xlabel('Local Time (UTC+2)','fontsize',14)
    xlim([min(x)-20/1440 max(x)+20/1440])
    legend('BKG 5 sec.', 'Ambient 5 sec.', 'offset corr.')
    grid on
    
    set(gcf,'PaperUnits','centimeters','PaperSize',[21 29.7],'PaperPositionMode','auto')
    print('-dpng','-r300', '-painters', [dir, '/PINCii_offset_corr_run_', num2str(runs(run)), '.png'])
    saveas(gcf,[dir, '/PINCii_offset_corr_run_', num2str(runs(run)), '.fig'])
    close;
    disp(['... PINCii data, run number: ', num2str(runs(run)), ' start at: ', ...
        datestr(input_data(1,1)), ', figure saved ...']);
    
end

%% save data
data = offset_data;
save([dir, '/data.mat'], 'data')
dataColumnHeaders = [dataColumnHeaders(1:3), 'bkg_SD', dataColumnHeaders(5)];
save([dir, '/dataColumnHeaders.mat'], 'dataColumnHeaders')
disp('... PINCii offset correction data saved ...')