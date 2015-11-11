clear all
close all

% Calculates FFDI from Weather Stations

load('DF_6840_40543')
load('T_max_1900_2010')
load('RH_1900_2010')
load('W_1900_2010')

size_p = size(T_max_1900_2010);
z = size_p(1,1);


FFDI_P_6840_40543 = zeros(z,24);

for j = 1:24
    
    for i = 6840:z
   
        FFDI_P_6840_40543(i,j) = 1.2753*exp(0.987*log(DF_6840_40543(i,j)) + 0.0338*T_max_1900_2010(i,j) +0.0234*W_1900_2010(i,j) - 0.0345*RH_1900_2010(i,j));
    
             if FFDI_P_6840_40543(i,j) > 1000;
            
                FFDI_P_6840_40543(i,j) = NaN;
        
             elseif FFDI_P_6840_40543(i,j) == 0;
           
                    FFDI_P_6840_40543(i,j) = NaN;
            
             elseif FFDI_P_6840_40543(i,j) < 0.0001;
            
                    FFDI_P_6840_40543(i,j) = NaN; 
            
             end    
    
    end

end

