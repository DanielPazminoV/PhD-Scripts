close all
clear all

% Calculates average precipitation in Victoria from reanalysis data for
% for a standard period of  30 years.

% P = ncread('prate.1900-2010.2d.nc','prate');
% P_size = size(P);
% n = P_size(1,3);
load('P_region_1972_2010.mat')

% Selects precipitation only in Victoria
% This step is too time consuming to perform each time,
% the "Precipitation_region" array has already been saved (line 10).


% P_region_1972_2010 = zeros(180,91,14245);
% 
% 
% for k = 26297:40542
%     
%     P_region_1972_2010(71:76,63:66,k-26296) = P(71:76,63:66,k);
%     P_region_1972_2010(P_region_1972_2010==0) = NaN;
%     
% end
% 
% save P_region_1972_2010.mat

size_p = size(P_region_1972_2010);
x = size_p(1,1);
y = size_p(1,2);
z = size_p(1,3);


% Calcualtes daily averages

P_region_1972_2010_avg_1 = zeros (1,y,z);

for i = 1:z
    
    P_region_1972_2010_avg_1(:,:,i) = nanmean(P_region_1972_2010(:,:,i));
    
end

P_region_1972_2010_avg_2 = zeros (1,1,z);

for i = 1:z
    
    P_region_1972_2010_avg_2(:,:,i) = nanmean(P_region_1972_2010_avg_1(:,:,i));
    
end

% Calculates anual averages 

 P_daily_avg = squeeze(P_region_1972_2010_avg_2(1,1,:));
 
% Prepares indice for leap years
 
m = zeros(39,2);
n = zeros(39,2);

for i = 1:39
    
    m(i,2) = 365; 
    
    for j = 5:5:35
        
        m(j,2) = 366;
        
    end
    
end

m(1,1) = 1;

for i = 2:39
    
    m(i,1) = m(i-1,1) + m(i-1,2);
    
end


for i = 1:39
    
    n(i,2) = 365;
    
    for j = 4:4:36
        
        n(j,2) = 366;
        
    end
    
end

n(1,1) = 366;

for i = 2:39
    
    n(i,1) = n(i-1,1) + n(i-1,2);
    
end
 
% Considering 37 years

Annual_prep = zeros(38,1);

for i = 1:38;
    
    x = m(i,1);
    y = n(i,1);
    
    Annual_prep(i,1) = sum(P_daily_avg(x:y,1));
            
            
end

Avg_annual_prep = mean(Annual_prep);

% save Avg_annual_prep.mat


  

 
 
 
 
 
 
 
 
 
 
