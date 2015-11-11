clear all
close all

% Plots seasvonal (DJF) FFDI for Weather Stations in Victoria for the period
% 1972-2010

load('WS_1974_2010')
load('TCRbc_1919_2010')
load('TCRbc_1974_2010')
load('Seasons_1919_2010')
load('Seasons_1974_2010')

plot(Seasons_1974_2010, WS_1974_2010,'-b', 'linewidth',3)

hold on

plot(Seasons_1919_2010, TCRbc_1919_2010, '-r', 'linewidth',2)

hold on

%plot(Seasons_1974_2010, TCRbc_1974_2010, '-b', 'linewidth',2)


hold off

set(gca, 'FontSize', 18)
xlabel('Bushfire seasons')
ylabel('Cumulative FFDI')
%title('Seasonal FFDI in Victoria, Australia for the period 1919-2010 (DJF)')
axis([1919, 2010, 400, 1850])
%legend('WS 1974-2010', 'TCRbc 1919-2010', 'TCRbc 1974-2010', -1)
legend('WS', '20CR(bc)', -1)

%print('FFDI_cum_1919_2010', '-dpng', '-r300'); %<-Save as PNG with 300 DPI
saveas(gcf,'FFDI_cum_1919_2010','epsc')
