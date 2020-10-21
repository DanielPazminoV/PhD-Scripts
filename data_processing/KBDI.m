clear all
close all

% Calculates KBDI from reanalysis data

load('P_region_1972_2010');
load('Air_region_1972_2010');
load('Avg_annual_prep');

Psum = zeros(14246,120);

% Takes the values from the 3rd dimension of "P_region_1972_2010" in the
% coordiantes of Victoria and puts them in columns to apply the same metholodolgy 
% of calculation of KDBI

for i = 1:5:120
    
    for j = 1:14246
        
        if i == 1
            
            n = 63;
            m = 71;
            
        elseif i == 6
            
            n = 64;
            m = 71;
        
        elseif i == 11
            
            n = 65;
            m = 71;
            
        elseif i == 16
            
            n = 66;
            m = 71;
            
        
        elseif i == 21
            
            n = 63;
            m = 72;
            
        elseif i == 26
            
            n = 64;
            m = 72;
        
        elseif i == 31
            
            n = 65;
            m = 72;
            
        elseif i == 36
            
            n = 66;
            m = 72;
            
        elseif i == 41
            
            n = 63;
            m = 73;
            
        elseif i == 46
            
            n = 64;
            m = 73;
        
        elseif i == 51
            
            n = 65;
            m = 73;
            
        elseif i == 56
            
            n = 66;
            m = 73;
            
        
        elseif i == 61
            
            n = 63;
            m = 74;
            
        elseif i == 66
            
            n = 64;
            m = 74;
        
        elseif i == 71
            
            n = 65;
            m = 74;
            
        elseif i == 76
            
            n = 66;
            m = 74;
            
        elseif i == 81
            
            n = 63;
            m = 75;
            
        elseif i == 86
            
            n = 64;
            m = 75;
        
        elseif i == 91
            
            n = 65;
            m = 75;
            
        elseif i == 96
            
            n = 66;
            m = 75;
            
         elseif i == 101
            
            n = 63;
            m = 76;
            
        elseif i == 106
            
            n = 64;
            m = 76;
        
        elseif i == 116
            
            n = 65;
            m = 76;
            
        elseif i == 111
            
            n = 66;
            m = 76;
            
        end
            
            
    Psum(j,i) = P_region_1972_2010(m,n,j);
    
    end
    
end

% Sums values consecutively through columns, difining the initial values of
% each column first.

for i = 1:5:120
    for j =1:1
        
        Psum(j,i+1) = Psum(j,i);
        
             
    end
end


for i = 1:5:120
    for j =2:14246
                    
        if Psum(j,i) == 0;
        
        Psum(j,i+1) = 0;
    
        else
            
             Psum(j,i+1) = Psum(j-1,i+1) + Psum(j,i);
        
        end
              
    end
    
end


% Substracts the 5mm interception value of the KBDI calculation procedure.

for i = 1:5:120
    
    for j =1:14246
                  
             Psum(j,i+2) = Psum(j,i+1) - 5;
             
    end
    
end

% Set negative values of the previus step to zero. All other values remain
% the same


for i = 1:5:120
    
    for j =1:14246
        
        if Psum(j,i+2) < 0
            
            Psum(j,i+3) = 0;
            
        else
            
            Psum(j,i+3) = Psum(j,i+2);
            
        end
             
    end
    
end

% Calculates the effective precipitation

for i = 1:5:120
    
    for j =1:14246
        
        if Psum(j,i+3) == 0
            
            Psum(j,i+4) = 0;
            
        elseif Psum(j,i+3) < Psum(j,i)
            
            Psum(j,i+4) = Psum(j,i+3);
            
        elseif Psum(j,i+3) > Psum(j,i)
            
            Psum(j,i+4) = Psum(j,i);
            
        end
             
    end
    
end

% Creates a matrix of effective precipitation values

Peff = zeros(14246,24);

for i = 1:5:120
    
    for j =1:14246
                  
             Peff(j,i) = Psum(j,i+4);
             
    end
    
end


% Takes the values from the 3rd dimension of "Air_region_1972_2010" in the
% coordiantes of Victoria and puts them in columns to apply the same metholodolgy 
% of calculation of KDBI. Tranforms each value from kelvin to celsius.

T_max = zeros(14246,24);

for i = 1:24
    
    for j = 1:14246
        
        if i == 1
            
            n = 63;
            m = 71;
            
        elseif i == 2
            
            n = 64;
            m = 71;
        
        elseif i == 3
            
            n = 65;
            m = 71;
            
        elseif i == 4
            
            n = 66;
            m = 71;
            
        
        elseif i == 5
            
            n = 63;
            m = 72;
            
        elseif i == 6
            
            n = 64;
            m = 72;
        
        elseif i == 7
            
            n = 65;
            m = 72;
            
        elseif i == 8
            
            n = 66;
            m = 72;
            
        elseif i == 9
            
            n = 63;
            m = 73;
            
        elseif i == 10
            
            n = 64;
            m = 73;
        
        elseif i == 11
            
            n = 65;
            m = 73;
            
        elseif i == 12
            
            n = 66;
            m = 73;
            
        
        elseif i == 13
            
            n = 63;
            m = 74;
            
        elseif i == 14
            
            n = 64;
            m = 74;
        
        elseif i == 15
            
            n = 65;
            m = 74;
            
        elseif i == 16
            
            n = 66;
            m = 74;
            
        elseif i == 17
            
            n = 63;
            m = 75;
            
        elseif i == 18
            
            n = 64;
            m = 75;
        
        elseif i == 19
            
            n = 65;
            m = 75;
            
        elseif i == 20
            
            n = 66;
            m = 75;
            
         elseif i == 21
            
            n = 63;
            m = 76;
            
        elseif i == 22
            
            n = 64;
            m = 76;
        
        elseif i == 23
            
            n = 65;
            m = 76;
            
        elseif i == 24
            
            n = 66;
            m = 76;
            
        end
            
            
    T_max(j,i) = Air_region_1972_2010(m,n,j)-273;
    
    end
    
end

 
% % Calcualtes soil moisture deficit

SMD = zeros(14246,24);

% Sets a initial value for each column. This values is 
% the average KBDI for all Victorian Station stating in 10/06/1972.

for i = 1:24
    for j =153:153
        
        SMD(j,i) = 60.6;
        
             
    end
end


A = zeros(14246,24);
B = zeros(14246,24);
C = zeros(1,24);
ET = zeros(14245,24);

%The calculation starts from the first of June of 1972 (record 153), which is
% first value in Lucas (2010) dataset. The initial value 

for i = 1:24
    for j =154:14246
        
        A(j,i) = (10^-3) * (203.2 - SMD(j-1,i));
        B(j,i) = (0.968 * exp(0.0875 * T_max(j,i) + 1.5552)) - 8.30;
        C(j,i) = (10.88 * exp(-0.001736 * Avg_annual_prep)) + 1;
        ET(j,i) = (A(j,i)*B(j,i))/C(j,i);
        SMD(j,i) = SMD(j-1,i) + ET(j,i) - Peff(j,i);
        
        if SMD(j,i) < 0
        
        SMD(j,i) = 0;
        
        elseif SMD(j,i) < 0
        
        SMD(j,i) = SMD(j-1,i) + ET(j-1,i) - Peff(j-1,i);
        
        end
        
             
    end
end


