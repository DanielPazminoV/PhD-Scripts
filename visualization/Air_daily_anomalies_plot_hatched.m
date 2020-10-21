load('20CRV2_GRID.mat')
load('Average_air_anomalies_plus_1.mat')
% load('Area_oz_zero.mat')
load('Hatch_lon_plus_1.mat')
load('Hatch_lat_plus_1.mat')

lon = zeros(16380,1);
lat = zeros(16380, 1);

m = 1:91:16379;
n = 91:91:16380;

for i = 1:91;
    
    x = m(i);
    y = n(i);
    
    lon(x:y,1) = Hatch_lon_plus_1(i,1:91);
    lat(x:y,1) = Hatch_lat_plus_1(i,1:91);
            
end

for i = 1:16380
    
    if lon(i) > 159
       
        lon(i) = NaN;
        
    elseif lon(i) < 110
        
        lon(i) = NaN;
        
    else
        
        lon(i) = lon(i);
        
    end
    
end


for i = 1:16380
    
    if lat(i) > 8
       
        lat(i) = NaN;
        
    elseif lat(i) < -42
        
        lat(i) = NaN;
        
    else
        
        lat(i) = lat(i);
        
    end
    
end

m_proj('Mercator','lon', [110 160], 'lat', [-44 8]);

m_pcolor(LON',LAT',Average_air_anomalies_plus_1);shading interp; 

m_text(lon,lat,'+')

m_coast('color','k');
m_grid('box','fancy', 'FontSize',16);

% add a standard colorbar.


h=colorbar('v','FontSize',18);
set(get(h,'ylabel'),'string','Surface temperature anomalies (^oC)','FontSize',18,'fontWeight','bold');
caxis([-3 3])

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

% print('Zero','-dpng', '-r600')
%print -depsc Zero.eps -r600
saveas(gcf,'Plus_1','epsc')


