clear all
close all

load('20CRV2_GRID.mat')
load('Region.mat')

m_proj('Mercator','lon', [100 165], 'lat', [-50 0]);

m_pcolor(LON',LAT', Region);shading interp;

m_coast('color','k');
% m_grid('box','fancy');
m_grid

% add a standard colorbar.
h=colorbar('v');
set(get(h,'ylabel'),'string','Air temperature anomalies (degC)');
caxis([-0.2 0.2])
