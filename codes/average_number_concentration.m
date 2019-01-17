function [data, dataColumnHeaders] = average_number_concentration(dir, data_concentration_updated, ...
    dataColumnHeaders, beginFlushTime, endFlushTime)
%% step 5:
% get average data for each measurement status (background/ambient, by valve)
%
% folder: './05_average_number_concentration'
% 
% fuction [data, dataColumnHeaders] = average_number_concentration(dir,data, 
%             dataColumnHeaders, beginFlushTime, endFlushTime)
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

%% load data from last step
% start_time, end_time, INP, valve, run_number
load(data_concentration_updated);
load(dataColumnHeaders);

%% select, rebuild data column orders 
data_concentration_updated = data_concentration_updated(data_concentration_updated(:,1) ~= 0,:);
data_concentration_updated = [data_concentration_updated(:,2)-5/60/1440 data_concentration_updated(:,2) data_concentration_updated(:,6) data_concentration_updated(:,71) data_concentration_updated(:,1)];
dataColumnHeaders = {'start_time' 'end_time' 'INP' 'bkg_SD' 'run_number'};

input_data = data_concentration_updated; % backup input data for future use

%% average data for each measurement status
beginFlushTime = beginFlushTime/60/1440; % sec. to day
endFlushTime = endFlushTime/60/1440; % sec. to day

runs = unique(data_concentration_updated(:,5));   % run numbers
ave_data = []; % to store averaged data
for run = 1:length(runs) % do loop for average by run_number
    data_run = data_concentration_updated(data_concentration_updated(:,5)==run,:);  % get each run data

    valve_diff = find(diff(data_run(:,4)) ~= 0); % get valve change point
    valve_time = [[1; valve_diff+1], [valve_diff; size(data_run,1)]]; % valve status matrix

    for n_valve = 1:size(valve_time,1)
        start_point = valve_time(n_valve,1); % start row of this valve status
        end_point = valve_time(n_valve,2);   % end row of this valve status

        if data_run(end_point,1)-data_run(start_point,1)>1/1440   % only use status longer than 1 min
            index = (data_run(:,1)>data_run(start_point,1)+beginFlushTime)&...
                (data_run(:,1)<data_run(end_point,1)-endFlushTime); % remove flushing data
            start_time = min(data_run(index, 1));   % start time of this point
            end_time = max(data_run(index, 2)); % end time of this point
            INP = mean(data_run(index,3));  % averaged data of this point
            valve = data_run(start_point, 4);   % valve status of this point
            run_number = data_run(start_point, 5);  % run_number of this point
            ave_data = [ave_data; [start_time, end_time, INP, valve, run_number]];
        end
    end
end

%% plot 
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
    plot(x,y, 'go')
    datetick('x')
    
    % plot 5 sec. ambient
    index = input_data(:,5)==runs(run) & input_data(:,4)==0;
    x = (input_data(index,1)+input_data(index,2))/2;
    y = input_data(index,3);
    plot(x,y, 'mo')
    datetick('x')
    
    % plot averaged background
    index = ave_data(:,5)==runs(run) & ave_data(:,4)==1;
    x = (ave_data(index,1)+ave_data(index,2))/2;
    y = ave_data(index,3);
    plot(x,y, 'b*', 'MarkerSize', 20)
    datetick('x')
    
    % plot averaged ambient
    index = ave_data(:,5)==runs(run) & ave_data(:,4)==0;
    x = (ave_data(index,1)+ave_data(index,2))/2;
    y = ave_data(index,3);
    plot(x,y, 'k*', 'MarkerSize', 20)
    datetick('x')
    
    index = input_data(:,5)==runs(run);
    select_data = input_data(index,1);
    
    title(['PINCii data, run number: ', num2str(runs(run)), ' start at: ', ...
        datestr(select_data(1))],'FontSize',16)
    ylabel('#/L','fontsize',14)
    xlabel('UTC','fontsize',14)
    legend('BKG 5 sec.', 'Ambient 5 sec.', 'BKG Ave.', 'Ambient Ave.')
    grid on
    
    set(gcf,'PaperUnits','centimeters','PaperSize',[21 29.7],'PaperPositionMode','auto')
    print('-dpng','-r300', '-painters', [dir, '/PINCii_ave_run_', num2str(runs(run)), '.png'])
    saveas(gcf,[dir, '/PINCii_ave_run_', num2str(runs(run)), '.fig'])
    close;
    disp(['... PINCii data, run number: ', num2str(runs(run)), ' start at: ', ...
        datestr(select_data(1)), ', figure saved ...']);
end

%% save data
data = ave_data;
save([dir, '/data.mat'], 'data')
save([dir, '/dataColumnHeaders.mat'], 'dataColumnHeaders')
disp('... PINCii averaged data saved ...')


