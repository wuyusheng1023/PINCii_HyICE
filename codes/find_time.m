function [date_time] = find_time(data,date)
% Function to find the corresponding date & time in the OPC data
% data is the column with all the dates in datenum format
% date is in datenum format as well 

date_time=find(round(data,7)==round(date,7));
while isempty(date_time)
    date=addtodate(date,1,'second');
    date_time=find(round(data,7)==round(date,7));
end

end

