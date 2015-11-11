% Calculates anomalies for bushfire events for different days

clear all 
close all

% Loads the anomalies and bufre records files and determines
%the size of the files

Air_anomalis = ncread('air.anom.1960-2011.nc','air');
load('Bushfire_seasonal_djf.mat')
load('Leap_seasons')
n = length(Bushfire_seasonal_djf);
size_1 = size(Leap_seasons); 
m = size_1(1,1);

% Prealocates memory for the bushfire records with a zeros matrix.

Bushfire_records_n = zeros(n,1);

% Modifies the time steps of the anomalies file to select dates close to
% original bushfire dates (d-1, d-2, d-3...).

 for i = 1:n
    
    Bushfire_records_n(i,1) = Bushfire_seasonal_djf(i,1)+0;
    
 end
 
 % Preallocates memory for the bushfire days anomalies with a zeros matrix.
 
 Air_anomalis_n = zeros(180,91,n);
 
 % Compares the time steps of the bushfire records the anomalies file
 % save the anomalies of bushfire dates in a separete matrix.
  
 for j = 1:1:n

             k = Bushfire_records_n(j,1);
     
             Air_anomalis_n(:,:,j) = Air_anomalis(:,:,k);
             
 end
          
 
 % Reduces the selected anomalies matrix to the first level even though
 % the orignal file was for level 1. DEtermines the size of the final file
 % Calcualtes the average seasonal anomaly
 
%  
%  Air_anomalis_n = squeeze(Air_anomalis_n(:,:,1,:));
%  W_size_2 = size(Air_anomalis_n);
% %  
  Avg_snl_anom_djf = mean(Air_anomalis_n,3);
  
  % Calculates the anomalies per season considering leap years
 
Anom_per_season_djf = zeros(180,91,n);
Avg_per_season_djf = zeros(180,91,m);

for i = 1:1
    
    x = Leap_seasons(i,1);
    y = Leap_seasons(i,2);
    
    Anom_per_season_djf(:,:,x:y) = Air_anomalis_n(:,:,x:y);
    
    Anom_per_season_djf(:,:,(y+1):n) = [];
    
    Avg_per_season_djf(:,:,i) = mean(Anom_per_season_djf,3);
    
    Anom_per_season_djf = zeros(180,91,n);
    
end


for i = 2:m
    
    x = Leap_seasons(i,1);
    y = Leap_seasons(i,2);
    
    Anom_per_season_djf(:,:,x:y) = Air_anomalis_n(:,:,x:y);
        
    Anom_per_season_djf(:,:,1:(x-1)) = [];
    
    size_p = size( Anom_per_season_djf);
    
    m = size_p(1,3);
    
    Anom_per_season_djf(:,:,(y-x+1):m) = [];
    
    Avg_per_season_djf(:,:,i) = mean(Anom_per_season_djf,3);
    
    Anom_per_season_djf = zeros(180,91,n);
    
end

save('Avg_snl_anom_djf.mat','Avg_snl_anom_djf') 
save('Avg_per_season_djf.mat','Avg_per_season_djf')


   

    

 
 
    
             

     
     