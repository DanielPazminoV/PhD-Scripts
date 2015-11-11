clear all
close all

% Creates matrix of statistically significant areas

load('Avg_snl_anom_djf.mat')
load('T_matrix_djf.mat')

Significant_anom_djf = zeros(180,91);

for i = 1:180
    for j = 1:91
       
        if isnan(T_matrix_djf(i,j))
            
          Significant_anom_djf(i,j) = NaN;
          
        else 
            
          Significant_anom_djf(i,j) = Avg_snl_anom_djf(i,j); 
            
        end
            
            
    end
end

save('Significant_anom_djf.mat','Significant_anom_djf')