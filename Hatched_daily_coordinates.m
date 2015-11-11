load('LON.mat')
load('LAT.mat')
load('Significant_anom_zero.mat')

lon = LON';
lat = LAT';

Hatch_lon_zero = zeros(180,91);
Hatch_lat_zero = zeros(180,91);


for i = 1:180
    for j = 1:91
       
        if isnan(Significant_anom_zero(i,j))
            
          Hatch_lon_zero(i,j) = NaN;
          
        else 
            
          Hatch_lon_zero(i,j) = lon(i,j); 
            
        end
            
            
    end
end

for i = 1:180
    for j = 1:91
       
        if isnan(Significant_anom_zero(i,j))
            
          Hatch_lat_zero(i,j) = NaN;
          
        else 
            
          Hatch_lat_zero(i,j) = lat(i,j); 
            
        end
            
            
    end
end

save('Hatch_lon_zero.mat','Hatch_lon_zero')
save('Hatch_lat_zero.mat','Hatch_lat_zero')
