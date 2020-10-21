% Calculates anomalies for bushfire events for different days

clear all 
close all

% Loads the anomalies and bushfire records files and determines
%the size of the files

SST_anomalis = ncread('HadISST_sst_anom_1960_2011.nc','sst');
load('b_records_1961_2011.mat')
load('Leap_seasons')
n = length(b_records_1961_2011);
W_size_1 = size(SST_anomalis); 
size_1 = size(Leap_seasons); 
m = size_1(1,1);

% Prealocates memory for the bushfire records with a zeros matrix.

records_n = zeros(n,1);

% Modifies the time steps of the anomalies file to select dates close to
% original bushfire dates (d-1, d-2, d-3...).

 for i = 1:n
    
    records_n(i,1) = b_records_1961_2011(i,1)+0;
    
 end
 
 % Preallocates memory for the bushfire days anomalies with a zeros matrix.
 
 SST_anomalis_n = zeros(360,180,n);
 
 % Compares the time steps of the bushfire records the anomalies file
 % save the anomalies of bushfire dates in a separete matrix.
 
 for j = 1:n

             k = records_n(j,1);
     
             SST_anomalis_n(:,:,j) = SST_anomalis(:,:,k);
             
 end
 
 Avg_sst_anom_djf = mean(SST_anomalis_n,3);
 
 % Calculates the anomalies per season considering leap years
 
Anom_per_season_djf = zeros(360,180,n);
Avg_per_season_djf = zeros(360,180,m);

for i = 1:1
    
    x = Leap_seasons(i,1);
    y = Leap_seasons(i,2);
    
    Anom_per_season_djf(:,:,x:y) = SST_anomalis_n(:,:,x:y);
    
    Anom_per_season_djf(:,:,(y+1):n) = [];
    
    Avg_per_season_djf(:,:,i) = mean(Anom_per_season_djf,3);
    
    Anom_per_season_djf = zeros(360,180,n);
    
end


for i = 2:m
    
    x = Leap_seasons(i,1);
    y = Leap_seasons(i,2);
    
    Anom_per_season_djf(:,:,x:y) = SST_anomalis_n(:,:,x:y);
        
    Anom_per_season_djf(:,:,1:(x-1)) = [];
    
    size_p = size( Anom_per_season_djf);
    
    m = size_p(1,3);
    
    Anom_per_season_djf(:,:,(y-x+1):m) = [];
    
    Avg_per_season_djf(:,:,i) = mean(Anom_per_season_djf,3);
    
    Anom_per_season_djf = zeros(360,180,n);
    
end
         
 save('Avg_sst_anom_djf.mat','Avg_sst_anom_djf')
save('Avg_per_season_djf.mat','Avg_per_season_djf')


 
 
 
 
 
 
 
 
 
 
 
 
 
 





