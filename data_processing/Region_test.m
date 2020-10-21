clear all
close all

load('Avg_snl_anom_sep_nov.mat')

Region = zeros(180,91);

for i = 1:180
    for j = 1:91
    
        Region(i:180,j:91) = NaN;
        Region(71:76,63:66) = Avg_snl_anom_sep_nov(71:76,63:66);
              
    end
end

save Region.mat
