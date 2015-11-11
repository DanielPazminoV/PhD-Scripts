% Calculates average anomalies for the sep-nov period in the 
% identified "hot-spot" box

clear all 
close all


% Creates a new anomalies array only with the sep-nov anomalies 

Anomalies = ncread('air.anomalies1.1900-2000.nc','air');
load('Bushfire_seasonal_djf.mat')
load('Anomalies_region.mat')
load('djf_rec_col.mat')
n = length(Bushfire_seasonal_djf);

Anomalies_n = zeros(180,91,1,n);

for i = 1:n
    
   m = Bushfire_seasonal_djf(i,1);
   Anomalies_n(:,:,:,i) = Anomalies(:,:,:,m);

end

Anomalies_n = squeeze(Anomalies_n(:,:,1,:));
Size_anomalies = size(Anomalies_n);


% Selects anomalies only the identified box
% This step is too time consuming to perform each time
% The "Anomalies_region" array has already been saved


% Anomalies_region = zeros(180,91,n);
% 
% for i = 1:180
%    for j = 1:91
%        for k = 1:n
%     
%         Anomalies_region(i:180,j:91,k) = NaN;
%         Anomalies_region(72:77,60:64,k) = Anomalies_n(72:77,60:64,k);
%         
%         end      
%     end
% end


% Calculates the seasonal average anomalies (dec-feb) for each year in the period 1900-2010 
% Converts daily to seasonal for each year

Avg_anomalies_1 = zeros(180,91,91);
Avg_anomalies_2 = zeros(180,91,110);

for j = 1:110
    
    for i = 1:90
    
   m = djf_rec_col(i,j);
   Avg_anomalies_1(:,:,i) = Anomalies_region(:,:,m);
    
    end
    
    Avg_anomalies_2(:,:,j) = mean(Avg_anomalies_1,3);
end
    


% Calculates average anomalies in the box for each season in the period 1900-2010 

Avg_anomalies_t_0 = zeros(1,91,110);

for i = 1:110
    
    Avg_anomalies_t_0(:,:,i) = nanmean(Avg_anomalies_2(:,:,i));
    
end

Avg_anomalies_t = zeros(1,1,110);

for i = 1:110
    
    Avg_anomalies_t(:,:,i) = nanmean(Avg_anomalies_t_0(:,:,i));
    
end

 Avg_anomalies_t = squeeze(Avg_anomalies_t(:,1,:));
