clear all
close all

load('LON.mat')
load('LAT.mat')
load('Significant_anom_djf.mat')

lon = LON';
lat = LAT';

Hatch_lon_djf = zeros(180,91);
Hatch_lat_djf = zeros(180,91);


for i = 1:180
    for j = 1:91
       
        if isnan(Significant_anom_djf(i,j))
            
          Hatch_lon_djf(i,j) = NaN;
          
        else 
            
          Hatch_lon_djf(i,j) = lon(i,j); 
            
        end
            
            
    end
end

for i = 1:180
    for j = 1:91
        
        if isnan(Significant_anom_djf(i,j))
            
          Hatch_lat_djf(i,j) = NaN;
          
        else 
            
          Hatch_lat_djf(i,j) = lat(i,j); 
            
        end
            
            
    end
end

save('Hatch_lon_djf.mat','Hatch_lon_djf')
save('Hatch_lat_djf.mat','Hatch_lat_djf')
