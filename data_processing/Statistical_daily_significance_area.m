clear all
close all

% Creates matrix of statistically significant areas

load('Average_air_anomalies_zero.mat')
load('T_matrix_zero.mat')

Significant_anom_zero = zeros(180,91);

for i = 1:180
    for j = 1:91
       
        if isnan(T_matrix_zero(i,j))
            
          Significant_anom_zero(i,j) = NaN;
          
        else 
            
          Significant_anom_zero(i,j) = Average_air_anomalies_zero(i,j); 
            
        end
            
            
    end
end

save('Significant_anom_zero.mat','Significant_anom_zero')
