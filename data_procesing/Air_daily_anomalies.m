% Calculates anomalies for bushfire events for different days

clear all 
close all

% Loads the anomalies and bufre records files and determines
%the size of the files

Air_anomalis = ncread('air.anom.1961-2011.nc','air');
load('BE_records.mat')
n = length(BE_records);
W_size_1 = size(Air_anomalis); 

% Prealocates memory for the bushfire records with a zeros matrix.

Bushfire_records_n = zeros(n,1);

% Modifies the time steps of the anomalies file to select dates close to
% original bushfire dates (d-1, d-2, d-3...).

 for i = 1:n
    
    Bushfire_records_n(i,1) = BE_records(i,1)-0;
    
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
 
%  Air_anomalis_n = squeeze(Air_anomalis_n(:,:,1,:));
 W_size_2 = size(Air_anomalis_n);

Average_air_anomalies_zero = mean(Air_anomalis_n,3);
 
 % Selects a couple fo records (bushfire dates) to validate the script
 
%  for l = 1:1
%     
%      Air_anomaly_1 = Air_anomalis_n(:,:,2);
%      
%  end

save('Average_air_anomalies_zero.mat','Average_air_anomalies_zero')


 
 
 
 
 
 
 
 
 
 
 
 
 
 





