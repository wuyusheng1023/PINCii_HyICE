function [data, dataColumnHeaders] = ...
    INP_uncertainty(dir, data, dataColumnHeaders, flowUncertainty, OPCUncertainty)
%% step 6:
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

%% load data from last step

load(data);
load(dataColumnHeaders);

%% calculate the system uncertainty with formula: flowUncertainty + bkg_SD + OPCUncertainty
% flowUncertainty: use 0.02 this time (2%)

data(:,4) = data(:,4)+data(:,3)*flowUncertainty+OPCUncertainty;

%% plot figures by run

runs = unique(data(:,5));  % run numbers
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
    
    % plot final data
    index = data(:,5)==runs(run);
    x = (data(index,1)+data(index,2))/2;
    y = data(index,3);
    err = data(index,4);
    errorbar(x,y,err, 'k*', 'MarkerSize', 20)
    datetick('x')
    
    index = data(:,5)==runs(run);
    select_data = data(index,1);
    
    title(['PINCii data, run number: ', num2str(runs(run)), ' start at: ', ...
        datestr(select_data(1))],'FontSize',16)
    ylabel('#/L','fontsize',14)
    xlabel('UTC','fontsize',14)
    xlim([min(x)-20/1440 max(x)+20/1440])
    grid on
    
    set(gcf,'PaperUnits','centimeters','PaperSize',[21 29.7],'PaperPositionMode','auto')
    print('-dpng','-r300', '-painters', [dir, '/PINCii_final_run_', num2str(runs(run)), '.png'])
    saveas(gcf,[dir, '/PINCii_final_run_', num2str(runs(run)), '.fig'])
    close;
    disp(['... PINCii data, run number: ', num2str(runs(run)), ' start at: ', ...
        datestr(select_data(1)), ', figure saved ...']);
end

%% save data
data = data(:,1:5);
save([dir, '/data.mat'], 'data')
dataColumnHeaders = dataColumnHeaders(1:5);
dlmwrite('filename.txt',data);
save([dir, '/dataColumnHeaders.mat'], 'dataColumnHeaders')
disp('... PINCii final data saved ...')



