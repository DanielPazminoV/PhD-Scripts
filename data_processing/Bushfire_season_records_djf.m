% Generates a list with the records of the days that belong to a season
% previos a bushfife season (Ex. sep-nov 2009 for bushfire season
% 2009-2010)

clear all
close all

load('bushfire_records.mat')
load('bushfire_seasons.mat')

Size_1 = size(bushfire_records);
n = Size_1(1,1);
Size_2 = size(bushfire_seasons);
m = Size_2(1,1);

Bushfire_seasonal_0 = zeros(21553,1);

for i = 1:n
    for j = 1:m
        
        a = bushfire_records(i,1);
        b = bushfire_records(i,2);
        c = bushfire_seasons(j,1);
        d = bushfire_seasons(j,2);
        
        if a == c && b == 12 
           
            Bushfire_seasonal_0(i,1) = bushfire_records(i,4);
           
            elseif a == d && b == 1
            
            Bushfire_seasonal_0(i,1) = bushfire_records(i,4);
            
            elseif a == d && b == 2
            
            Bushfire_seasonal_0(i,1) = bushfire_records(i,4);        
 
        end
    end
end

 Bushfire_seasonal_djf = Bushfire_seasonal_0(all(Bushfire_seasonal_0,2),:);
 
 save('Bushfire_seasonal_djf.mat','Bushfire_seasonal_djf')
 
 
 
 
