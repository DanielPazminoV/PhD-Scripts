% Sums (averages) seasonal values

load('FFDI_20cr_g25.mat')
load('Leap_seasons')

n = length(FFDI_20cr_g25);
size_1 = size(Leap_seasons); 
m = size_1(1,1);
 
Values_per_season_djf = zeros(n,1);
Sum_per_season_djf = zeros(m,1);

for i = 1:1
    
    x = Leap_seasons(i,1);
    y = Leap_seasons(i,2);
    
    Values_per_season_djf(x:y) = FFDI_20cr_g25(x:y);
    
    Values_per_season_djf((y+1):n) = [];
    
    Sum_per_season_djf(i) = sum(Values_per_season_djf);
    
    Values_per_season_djf = zeros(n);
    
end


for i = 2:m
    
    x = Leap_seasons(i,1);
    y = Leap_seasons(i,2);
    
    Values_per_season_djf(x:y) = FFDI_20cr_g25(x:y);
        
    Values_per_season_djf(1:(x-1)) = [];
    
    size_p = size(Values_per_season_djf);
    
    m = size_p(1,1);
    
    Values_per_season_djf((y-x+1):m) = [];
    
    Sum_per_season_djf(i) = sum(Values_per_season_djf);
    
    Values_per_season_djf = zeros(n);
    
end

save Sum_per_season_djf
