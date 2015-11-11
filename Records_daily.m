% Assigns netCDF records to bushfire (BE) events

clear all
close all

load('BE_dates_1961_2011')
load('Total_records_1961_2011')

size_1 = size(BE_dates_1961_2011);
n = size_1(1,1);
size_2 = size(Total_records_1961_2011);
m = size_2(1,1);

BE_records = zeros(n,1);

I = zeros(n,2);
I(1:n,1) = [1:n];
I(1:n,2) = [1:n];

for i= 1:n
    
    x = I(i,1);
    y = I(i,2);
    
    for j = x:y
    
        a = BE_dates_1961_2011(j,1);
        b = BE_dates_1961_2011(j,2);
        c = BE_dates_1961_2011(j,3);
        
        for k = 1:m
    
        d = Total_records_1961_2011(k,1);
        f = Total_records_1961_2011(k,2);
        g = Total_records_1961_2011(k,3);
        h = Total_records_1961_2011(k,4);
    
            if a == d && b == f && c == g
               
                    
                BE_records(x:y,1) = Total_records_1961_2011(k,4);
                       
            end
            
        end
           
    end
    
end

save('BE_records.mat','BE_records')




