clear all
close all

load('HadISST_GRID.mat')
load('Avg_sst_anom_djf.mat')
load('Hatch_lon_djf.mat')
load('Hatch_lat_djf.mat')

lon = zeros(64800,1);
lat = zeros(64800,1);

m = 1:180:64799;
n = 180:180:64800;

for i = 1:360;
    
    x = m(i);
    y = n(i);
    
    lon(x:y,1) = Hatch_lon_djf(i,1:180);
    lat(x:y,1) = Hatch_lat_djf(i,1:180);
            
end

for i = 1:2:64800
    
        lon(i) = NaN;
        lat(i) = NaN;    
end

for i = 1:64800
    
    if lat(i) > 60
       
        lat(i) = NaN;
        
    elseif lat(i) < -60
        
        lat(i) = NaN;
        
    else
        
        lat(i) = lat(i);
        
    end
    
end


for i = 1:64800
    
    if lon(i) > 178
       
        lon(i) = NaN;
        
    elseif lon(i) < -178
        
        lon(i) = NaN;
        
    else
        
        lon(i) = lon(i);
        
    end
    
end


m_proj('Mercator','lon', [-180 180], 'lat', [-60 60]);

m_pcolor(LON',LAT', Avg_sst_anom_djf);shading interp; 

m_text(lon,lat,'.')

m_coast('color','k');
m_grid('box','fancy', 'FontSize',16);

% add a standard colorbar.
h=colorbar('v','FontSize',18);
set(get(h,'ylabel'),'string','SST anomalies (^oC)','FontSize',18,'fontWeight','bold');
caxis([-0.5 0.5])

colormap([0.0	0.2	0.4;
0.0	0.3	0.6;
0.0	0.4	0.8;
0.0	0.5	1.0;
0.2	0.6	1.0;
0.4	0.7	1.0;
0.6	0.8	1.0;
0.8	0.9	1.0;
1.0	0.8	0.8;
1.0	0.6	0.6;
1.0	0.4	0.4;
1.0	0.2	0.2;
1.0	0.0	0.0;
0.8	0.0	0.0;
0.6	0.0	0.0;
0.4	0.0	0.0]); % red & blue in rgb

saveas(gcf,'Zero','epsc')


