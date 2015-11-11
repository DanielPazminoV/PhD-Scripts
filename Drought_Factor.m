clear all
close all

% Calculates Drought Factor

load('P_region_1972_2010.mat')
load('SMD.mat')

Pevents = zeros(14246,48);

% Takes the values from the 3rd dimension of "P_region_1972_2010" in the
% coordiantes of Victoria and puts them in columns to apply the same metholodolgy 
% of calculation of DF

for i = 1:2:48
    
    for j = 1:14246
        
        if i == 1
            
            n = 63;
            m = 71;
            
        elseif i == 3
            
            n = 64;
            m = 71;
        
        elseif i == 5
            
            n = 65;
            m = 71;
            
        elseif i == 7
            
            n = 66;
            m = 71;
            
        
        elseif i == 9
            
            n = 63;
            m = 72;
            
        elseif i == 11
            
            n = 64;
            m = 72;
        
        elseif i == 13
            
            n = 65;
            m = 72;
            
        elseif i == 15
            
            n = 66;
            m = 72;
            
        elseif i == 17
            
            n = 63;
            m = 73;
            
        elseif i == 19
            
            n = 64;
            m = 73;
        
        elseif i == 21
            
            n = 65;
            m = 73;
            
        elseif i == 23
            
            n = 66;
            m = 73;
            
        
        elseif i == 25
            
            n = 63;
            m = 74;
            
        elseif i == 27
            
            n = 64;
            m = 74;
        
        elseif i == 29
            
            n = 65;
            m = 74;
            
        elseif i == 31
            
            n = 66;
            m = 74;
            
        elseif i == 33
            
            n = 63;
            m = 75;
            
        elseif i == 35
            
            n = 64;
            m = 75;
        
        elseif i == 37
            
            n = 65;
            m = 75;
            
        elseif i == 39
            
            n = 66;
            m = 75;
            
         elseif i == 41
            
            n = 63;
            m = 76;
            
        elseif i == 43
            
            n = 64;
            m = 76;
        
        elseif i == 45
            
            n = 65;
            m = 76;
            
        elseif i == 47
            
            n = 66;
            m = 76;
            
        end
            
            
    Pevents(j,i) = P_region_1972_2010(m,n,j);
    
    end
    
end


% Selects rain events accordig to methodology (all event greater than 2mm)

for i = 1:2:48
    
    for j = 1:14246
        
        if Pevents(j,i) < 2
            
            Pevents(j,i) = 0;
            
        else
            
            Pevents(j,i) = Pevents(j,i);
            
        end
        
    end
end


% Sums events to find "significant rain events"

for i = 1:2:48
    for j =2:14246
                    
        if Pevents(j,i) == 0;
        
            Pevents(j,i+1) = 0;
    
        else
            
             Pevents(j,i+1) = Pevents(j-1,i+1) + Pevents(j,i);
        
        end
              
    end
    
end

for i = 2:2:48
    for j =2:14246-1
                    
        if Pevents(j,i) < Pevents(j+1,i);
        
            Pevents(j,i) = 0;
    
        else
            
             Pevents(j,i) = Pevents(j,i);
        
        end
              
    end
    
end

% Creates matrices of initial and final indices for consecutive rain days

 i_matrix = zeros(14246,48);
 
 for i = 1:2:48
    for j =2:14246
        
        if Pevents(j,i) > 0;
            
            A = j;
        
            i_matrix(j,i) = A;
                     
        end
        
    end
    
 end
 
 
 for i = 1:2:48
    for j =2:14246-1
        
        if i_matrix(j-1,i) == 0 && i_matrix(j+1,i) == 0
        
        i_matrix(j,i) = 0;
        
        end
        
    end
 end
 
  for i = 1:2:48
    
      for j =2:14246-1
        
        if i_matrix(j-1,i) == 0 && i_matrix(j,i) > 0
        
            i_matrix(j,i+1) = i_matrix(j,i);
        
        elseif i_matrix(j,i) > 0 && i_matrix(j+1,i) == 0
        
            i_matrix(j,i+1) = i_matrix(j,i);
        
        end
        
       end
  end
  
  
  i_matrix_zero = zeros(14246,49);
  
 for i = 1:48
    
    for j =2:14246
          
          i_matrix_zero(j,i) = i_matrix(j,i);
          
     end
      
 end
 
 
i_matrix_1 = zeros(14246,1);

  for i = 1:2
    
    for j =2:14246
          
        i_matrix_1(j,i) = i_matrix_zero(j,i+1);
          
     end
      
  end
            i_matrix_1(1:14246,2) = 0;
            i_matrix_1( ~any(i_matrix_1,2), : ) = [];
            s1 = size(i_matrix_1);

     
        
 
  
  i_matrix_2 = zeros(14246,1);

  for i = 3:4
    
    for j =2:14246
          
        i_matrix_2(j,i) = i_matrix_zero(j,i+1);
          
     end
      
  end
 

            i_matrix_2( :, ~any(i_matrix_2,1) ) = [];
            i_matrix_2(1:14246,2) = 0;
            i_matrix_2( ~any(i_matrix_2,2), : ) = [];
            s2 = size(i_matrix_2);
 
   
        i_matrix_3 = zeros(14246,1);

  for i = 5:6
    
    for j =2:14246
          
        i_matrix_3(j,i) = i_matrix_zero(j,i+1);
          
     end
      
  end
 
            i_matrix_3( :, ~any(i_matrix_3,1) ) = [];
            i_matrix_3(1:14246,2) = 0;
            i_matrix_3( ~any(i_matrix_3,2), : ) = [];
            s3 = size(i_matrix_3);
 
  
         i_matrix_4(j,i) = i_matrix_zero(j,i);
         
         
for i = 7:8
    
    for j =2:14246
          
        i_matrix_4(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_4( :, ~any(i_matrix_4,1) ) = [];
            i_matrix_4(1:14246,2) = 0;
            i_matrix_4( ~any(i_matrix_4,2), : ) = [];
            s4 = size(i_matrix_4);
         
         
         
                  i_matrix_5(j,i) = i_matrix_zero(j,i);
         
         
for i = 9:10
    
    for j =2:14246
          
        i_matrix_5(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_5( :, ~any(i_matrix_5,1) ) = [];
            i_matrix_5(1:14246,2) = 0;
            i_matrix_5( ~any(i_matrix_5,2), : ) = [];
            s5 = size(i_matrix_5);
         
     
         
                           i_matrix_6(j,i) = i_matrix_zero(j,i);
         
         
for i = 11:12
    
    for j =2:14246
          
        i_matrix_6(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_6( :, ~any(i_matrix_6,1) ) = [];
            i_matrix_6(1:14246,2) = 0;
            i_matrix_6( ~any(i_matrix_6,2), : ) = [];
            s6 = size(i_matrix_6);
         
         
                              i_matrix_7(j,i) = i_matrix_zero(j,i);
         
         
for i = 13:14
    
    for j =2:14246
          
        i_matrix_7(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_7( :, ~any(i_matrix_7,1) ) = [];
            i_matrix_7(1:14246,2) = 0;
            i_matrix_7( ~any(i_matrix_7,2), : ) = [];
            s7 = size(i_matrix_7);   
         
         
                                  i_matrix_8(j,i) = i_matrix_zero(j,i);
         
         
for i = 15:16
    
    for j =2:14246
          
        i_matrix_8(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_8( :, ~any(i_matrix_8,1) ) = [];
            i_matrix_8(1:14246,2) = 0;
            i_matrix_8( ~any(i_matrix_8,2), : ) = [];
            s8 = size(i_matrix_8);    
         
     
         
                                           i_matrix_9(j,i) = i_matrix_zero(j,i);
         
         
for i = 17:18
    
    for j =2:14246
          
        i_matrix_9(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_9( :, ~any(i_matrix_9,1) ) = [];
            i_matrix_9(1:14246,2) = 0;
            i_matrix_9( ~any(i_matrix_9,2), : ) = [];
            s9 = size(i_matrix_9);  
         
         
                                                   i_matrix_10(j,i) = i_matrix_zero(j,i);
         
         
for i = 19:20
    
    for j =2:14246
          
        i_matrix_10(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_10( :, ~any(i_matrix_10,1) ) = [];
            i_matrix_10(1:14246,2) = 0;
            i_matrix_10( ~any(i_matrix_10,2), : ) = [];
            s10 = size(i_matrix_10);  
       
         
         
                                                            i_matrix_11(j,i) = i_matrix_zero(j,i);
         
         
for i = 21:22
    
    for j =2:14246
          
        i_matrix_11(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_11( :, ~any(i_matrix_11,1) ) = [];
            i_matrix_11(1:14246,2) = 0;
            i_matrix_11( ~any(i_matrix_11,2), : ) = [];
            s11 = size(i_matrix_11); 
         
         
         
         
                                                                     i_matrix_12(j,i) = i_matrix_zero(j,i);
         
         
for i = 23:24
    
    for j =2:14246
          
        i_matrix_12(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_12( :, ~any(i_matrix_12,1) ) = [];
            i_matrix_12(1:14246,2) = 0;
            i_matrix_12( ~any(i_matrix_12,2), : ) = [];
            s12 = size(i_matrix_12); 
         
         
         
         i_matrix_13(j,i) = i_matrix_zero(j,i);
         
         
for i = 25:26
    
    for j =2:14246
          
        i_matrix_13(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_13( :, ~any(i_matrix_13,1) ) = [];
            i_matrix_13(1:14246,2) = 0;
            i_matrix_13( ~any(i_matrix_13,2), : ) = [];
            s13 = size(i_matrix_13); 
         
         
                  i_matrix_14(j,i) = i_matrix_zero(j,i);
         
         
for i = 27:28
    
    for j =2:14246
          
        i_matrix_14(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_14( :, ~any(i_matrix_14,1) ) = [];
            i_matrix_14(1:14246,2) = 0;
            i_matrix_14( ~any(i_matrix_14,2), : ) = [];
            s14 = size(i_matrix_14); 
        
         
         
         i_matrix_15(j,i) = i_matrix_zero(j,i);
         
         
for i = 29:30
    
    for j =2:14246
          
        i_matrix_15(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_15( :, ~any(i_matrix_15,1) ) = [];
            i_matrix_15(1:14246,2) = 0;
            i_matrix_15( ~any(i_matrix_15,2), : ) = [];
            s15 = size(i_matrix_15); 
         
         
                  i_matrix_16(j,i) = i_matrix_zero(j,i);
         
         
for i = 31:32
    
    for j =2:14246
          
        i_matrix_16(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_16( :, ~any(i_matrix_16,1) ) = [];
            i_matrix_16(1:14246,2) = 0;
            i_matrix_16( ~any(i_matrix_16,2), : ) = [];
            s16 = size(i_matrix_16); 
         
         
                           i_matrix_17(j,i) = i_matrix_zero(j,i);
         
         
for i = 33:34
    
    for j =2:14246
          
        i_matrix_17(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_17( :, ~any(i_matrix_17,1) ) = [];
            i_matrix_17(1:14246,2) = 0;
            i_matrix_17( ~any(i_matrix_17,2), : ) = [];
            s17 = size(i_matrix_17); 
         
         
         
                                    i_matrix_18(j,i) = i_matrix_zero(j,i);
         
         
for i = 35:36
    
    for j =2:14246
          
        i_matrix_18(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_18( :, ~any(i_matrix_18,1) ) = [];
            i_matrix_18(1:14246,2) = 0;
            i_matrix_18( ~any(i_matrix_18,2), : ) = [];
            s18 = size(i_matrix_18); 
         
         
                                             i_matrix_19(j,i) = i_matrix_zero(j,i);
         
         
for i = 37:38
    
    for j =2:14246
          
        i_matrix_19(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_19( :, ~any(i_matrix_19,1) ) = [];
            i_matrix_19(1:14246,2) = 0;
            i_matrix_19( ~any(i_matrix_19,2), : ) = [];
            s19 = size(i_matrix_19); 
         
         
         
                                                      i_matrix_20(j,i) = i_matrix_zero(j,i);
         
         
for i = 39:40
    
    for j =2:14246
          
        i_matrix_20(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_20( :, ~any(i_matrix_20,1) ) = [];
            i_matrix_20(1:14246,2) = 0;
            i_matrix_20( ~any(i_matrix_20,2), : ) = [];
            s20 = size(i_matrix_20); 
         
         
         
                                                               i_matrix_21(j,i) = i_matrix_zero(j,i);
         
         
for i = 41:42
    
    for j =2:14246
          
        i_matrix_21(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_21( :, ~any(i_matrix_21,1) ) = [];
            i_matrix_21(1:14246,2) = 0;
            i_matrix_21( ~any(i_matrix_21,2), : ) = [];
            s21 = size(i_matrix_21); 
         
         
         
                                                                        i_matrix_22(j,i) = i_matrix_zero(j,i);
         
         
for i = 43:44
    
    for j =2:14246
          
        i_matrix_22(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_22( :, ~any(i_matrix_22,1) ) = [];
            i_matrix_22(1:14246,2) = 0;
            i_matrix_22( ~any(i_matrix_22,2), : ) = [];
            s22 = size(i_matrix_22); 
         
         
         
                                                                            i_matrix_23(j,i) = i_matrix_zero(j,i);
         
         
for i = 45:46
    
    for j =2:14246
          
        i_matrix_23(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_23( :, ~any(i_matrix_23,1) ) = [];
            i_matrix_23(1:14246,2) = 0;
            i_matrix_23( ~any(i_matrix_23,2), : ) = [];
            s23 = size(i_matrix_23); 
         
         
         
                  
                                                                            i_matrix_24(j,i) = i_matrix_zero(j,i);
         
         
for i = 47:48
    
    for j =2:14246
          
        i_matrix_24(j,i) = i_matrix_zero(j,i+1);
          
     end
      
end
 
            i_matrix_24( :, ~any(i_matrix_24,1) ) = [];
            i_matrix_24(1:14246,2) = 0;
            i_matrix_24( ~any(i_matrix_24,2), : ) = [];
            s24 = size(i_matrix_24); 
         
  
         
  for j = 1:s1(1,1)-1
      
      i_matrix_1(j,2) = i_matrix_1(j+1,1);
      
  end
  
 
         i_matrix_1( :, all( ~any( i_matrix_1), 1 ) ) = [];
         i_matrix_1 = i_matrix_1(1:2:end,:);
         i_matrix_1( ~any(i_matrix_1,2), : ) = [];

         
         
         
 for j = 1:s2(1,1)-1
      
      i_matrix_2(j,2) = i_matrix_2(j+1,1);
      
  end
  
 
         i_matrix_2( :, all( ~any( i_matrix_2), 1 ) ) = [];
         i_matrix_2 = i_matrix_2(1:2:end,:);
         i_matrix_2( ~any(i_matrix_2,2), : ) = [];

         
         
 for j = 1:s3(1,1)-1
      
      i_matrix_3(j,2) = i_matrix_3(j+1,1);
      
  end
  
 
         i_matrix_3( :, all( ~any( i_matrix_3), 1 ) ) = [];
         i_matrix_3 = i_matrix_3(1:2:end,:);
         i_matrix_3( ~any(i_matrix_3,2), : ) = [];      
         
         
         
for j = 1:s4(1,1)-1
      
      i_matrix_4(j,2) = i_matrix_4(j+1,1);
      
end
  
 
         i_matrix_4( :, all( ~any( i_matrix_4), 1 ) ) = [];
         i_matrix_4 = i_matrix_4(1:2:end,:);
         i_matrix_4( ~any(i_matrix_4,2), : ) = [];      
         
         
for j = 1:s5(1,1)-1
      
      i_matrix_5(j,2) = i_matrix_5(j+1,1);
      
end
  
 
         i_matrix_5( :, all( ~any( i_matrix_5), 1 ) ) = [];
         i_matrix_5 = i_matrix_5(1:2:end,:);
         i_matrix_5( ~any(i_matrix_5,2), : ) = [];     
         
         
  for j = 1:s6(1,1)-1
      
      i_matrix_6(j,2) = i_matrix_6(j+1,1);
      
  end
  
 
         i_matrix_6( :, all( ~any( i_matrix_6), 1 ) ) = [];
         i_matrix_6 = i_matrix_6(1:2:end,:);
         i_matrix_6( ~any(i_matrix_6,2), : ) = [];       
         
         
   for j = 1:s7(1,1)-1
      
      i_matrix_7(j,2) = i_matrix_7(j+1,1);
      
  end
  
 
         i_matrix_7( :, all( ~any( i_matrix_7), 1 ) ) = [];
         i_matrix_7 = i_matrix_7(1:2:end,:);
         i_matrix_7( ~any(i_matrix_7,2), : ) = [];     
         
         
  for j = 1:s8(1,1)-1
      
      i_matrix_8(j,2) = i_matrix_8(j+1,1);
      
  end
  
 
         i_matrix_8( :, all( ~any( i_matrix_8), 1 ) ) = [];
         i_matrix_8 = i_matrix_8(1:2:end,:);
         i_matrix_8( ~any(i_matrix_8,2), : ) = [];   
         
 
  for j = 1:s9(1,1)-1
      
      i_matrix_9(j,2) = i_matrix_9(j+1,1);
      
  end
  
 
         i_matrix_9( :, all( ~any( i_matrix_9), 1 ) ) = [];
         i_matrix_9 = i_matrix_9(1:2:end,:);
         i_matrix_9( ~any(i_matrix_9,2), : ) = [];      
         
         
  for j = 1:s10(1,1)-1
      
      i_matrix_10(j,2) = i_matrix_10(j+1,1);
      
  end
  
 
         i_matrix_10( :, all( ~any( i_matrix_10), 1 ) ) = [];
         i_matrix_10 = i_matrix_10(1:2:end,:);
         i_matrix_10( ~any(i_matrix_10,2), : ) = [];     
         
         
  for j = 1:s11(1,1)-1
      
      i_matrix_11(j,2) = i_matrix_11(j+1,1);
      
  end
  
 
         i_matrix_11( :, all( ~any( i_matrix_11), 1 ) ) = [];
         i_matrix_11 = i_matrix_11(1:2:end,:);
         i_matrix_11( ~any(i_matrix_11,2), : ) = [];    
         
   
  for j = 1:s12(1,1)-1
      
      i_matrix_12(j,2) = i_matrix_12(j+1,1);
      
  end
  
 
         i_matrix_12( :, all( ~any( i_matrix_12), 1 ) ) = [];
         i_matrix_12 = i_matrix_12(1:2:end,:);
         i_matrix_12( ~any(i_matrix_12,2), : ) = [];
         
         
  for j = 1:s13(1,1)-1
      
      i_matrix_13(j,2) = i_matrix_13(j+1,1);
      
  end
  
 
         i_matrix_13( :, all( ~any( i_matrix_13), 1 ) ) = [];
         i_matrix_13 = i_matrix_13(1:2:end,:);
         i_matrix_13( ~any(i_matrix_13,2), : ) = [];       
         
         
  for j = 1:s14(1,1)-1
      
      i_matrix_14(j,2) = i_matrix_14(j+1,1);
      
  end
  
 
         i_matrix_14( :, all( ~any( i_matrix_14), 1 ) ) = [];
         i_matrix_14 = i_matrix_14(1:2:end,:);
         i_matrix_14( ~any(i_matrix_14,2), : ) = [];   
 
 
 for j = 1:s15(1,1)-1
      
      i_matrix_15(j,2) = i_matrix_15(j+1,1);
      
 end
  
 
         i_matrix_15( :, all( ~any( i_matrix_15), 1 ) ) = [];
         i_matrix_15 = i_matrix_15(1:2:end,:);
         i_matrix_15( ~any(i_matrix_15,2), : ) = [];
         
  
  for j = 1:s16(1,1)-1
      
      i_matrix_16(j,2) = i_matrix_16(j+1,1);
      
  end
  
 
         i_matrix_16( :, all( ~any( i_matrix_16), 1 ) ) = [];
         i_matrix_16 = i_matrix_16(1:2:end,:);
         i_matrix_16( ~any(i_matrix_16,2), : ) = [];
         
         
  for j = 1:s17(1,1)-1
      
      i_matrix_17(j,2) = i_matrix_17(j+1,1);
      
  end
  
 
         i_matrix_17( :, all( ~any( i_matrix_17), 1 ) ) = [];
         i_matrix_17 = i_matrix_17(1:2:end,:);
         i_matrix_17( ~any(i_matrix_17,2), : ) = [];    
         
         
  for j = 1:s18(1,1)-1
      
      i_matrix_18(j,2) = i_matrix_18(j+1,1);
      
  end
  
 
         i_matrix_18( :, all( ~any( i_matrix_18), 1 ) ) = [];
         i_matrix_18 = i_matrix_18(1:2:end,:);
         i_matrix_18( ~any(i_matrix_18,2), : ) = [];    
         
         
  for j = 1:s19(1,1)-1
      
      i_matrix_19(j,2) = i_matrix_19(j+1,1);
      
  end
  
 
         i_matrix_19( :, all( ~any( i_matrix_19), 1 ) ) = [];
         i_matrix_19 = i_matrix_19(1:2:end,:);
         i_matrix_19( ~any(i_matrix_19,2), : ) = [];     
         
  
  for j = 1:s20(1,1)-1
      
      i_matrix_20(j,2) = i_matrix_20(j+1,1);
      
  end
  
 
         i_matrix_20( :, all( ~any( i_matrix_20), 1 ) ) = [];
         i_matrix_20 = i_matrix_20(1:2:end,:);
         i_matrix_20( ~any(i_matrix_20,2), : ) = [];  
         
         
  for j = 1:s21(1,1)-1
      
      i_matrix_21(j,2) = i_matrix_21(j+1,1);
      
  end
  
 
         i_matrix_21( :, all( ~any( i_matrix_21), 1 ) ) = [];
         i_matrix_21 = i_matrix_21(1:2:end,:);
         i_matrix_21( ~any(i_matrix_21,2), : ) = [];       
         
         
  for j = 1:s22(1,1)-1
      
      i_matrix_22(j,2) = i_matrix_22(j+1,1);
      
  end
  
 
         i_matrix_22( :, all( ~any( i_matrix_22), 1 ) ) = [];
         i_matrix_22 = i_matrix_22(1:2:end,:);
         i_matrix_22( ~any(i_matrix_22,2), : ) = [];    
         
         
  for j = 1:s23(1,1)-1
      
      i_matrix_23(j,2) = i_matrix_23(j+1,1);
      
  end
  
 
         i_matrix_23( :, all( ~any( i_matrix_23), 1 ) ) = [];
         i_matrix_23 = i_matrix_23(1:2:end,:);
         i_matrix_23( ~any(i_matrix_23,2), : ) = []; 
         
         
  for j = 1:s24(1,1)-1
      
      i_matrix_24(j,2) = i_matrix_24(j+1,1);
      
  end
  
 
         i_matrix_24( :, all( ~any( i_matrix_24), 1 ) ) = [];
         i_matrix_24 = i_matrix_24(1:2:end,:);
         i_matrix_24( ~any(i_matrix_24,2), : ) = []; 
         
         
% % Relocates the sum of the rain events ("significant rain") of a group of consecutive rain days
% % to the day of the highest rain in the group of consecutive rain days         
         
group_er = zeros(14246,1);
group_sr = zeros(14246,1);     


for i = 1:(s1(1,1)/2)-1
            
        x = i_matrix_1(i,1);
        y = i_matrix_1(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,1);
            group_sr(j,1) = Pevents(j,2);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,2) = B;
            Pevents(Ib,2) = 0;
            
            else
                
            Pevents(Ib,2) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end

for i = 1:(s2(1,1)/2)-1
            
        x = i_matrix_2(i,1);
        y = i_matrix_2(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,3);
            group_sr(j,1) = Pevents(j,4);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,4) = B;
            Pevents(Ib,4) = 0;
            
            else
                
            Pevents(Ib,4) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end

for i = 1:(s3(1,1)/2)-1
            
        x = i_matrix_3(i,1);
        y = i_matrix_3(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,5);
            group_sr(j,1) = Pevents(j,6);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,6) = B;
            Pevents(Ib,6) = 0;
            
            else
                
            Pevents(Ib,6) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s4(1,1)/2)-1
            
        x = i_matrix_4(i,1);
        y = i_matrix_4(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,7);
            group_sr(j,1) = Pevents(j,8);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,8) = B;
            Pevents(Ib,8) = 0;
            
            else
                
            Pevents(Ib,8) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end

for i = 1:(s5(1,1)/2)-1
            
        x = i_matrix_5(i,1);
        y = i_matrix_5(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,9);
            group_sr(j,1) = Pevents(j,10);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,10) = B;
            Pevents(Ib,10) = 0;
            
            else
                
            Pevents(Ib,10) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s6(1,1)/2)-1
            
        x = i_matrix_6(i,1);
        y = i_matrix_6(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,11);
            group_sr(j,1) = Pevents(j,12);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,12) = B;
            Pevents(Ib,12) = 0;
            
            else
                
            Pevents(Ib,12) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s7(1,1)/2)-1
            
        x = i_matrix_7(i,1);
        y = i_matrix_7(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,13);
            group_sr(j,1) = Pevents(j,14);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,14) = B;
            Pevents(Ib,14) = 0;
            
            else
                
            Pevents(Ib,14) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s8(1,1)/2)-1
            
        x = i_matrix_8(i,1);
        y = i_matrix_8(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,15);
            group_sr(j,1) = Pevents(j,16);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,16) = B;
            Pevents(Ib,16) = 0;
            
            else
                
            Pevents(Ib,16) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s9(1,1)/2)-1
            
        x = i_matrix_9(i,1);
        y = i_matrix_9(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,17);
            group_sr(j,1) = Pevents(j,18);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,18) = B;
            Pevents(Ib,18) = 0;
            
            else
                
            Pevents(Ib,18) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s10(1,1)/2)-1
            
        x = i_matrix_10(i,1);
        y = i_matrix_10(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,19);
            group_sr(j,1) = Pevents(j,20);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,20) = B;
            Pevents(Ib,20) = 0;
            
            else
                
            Pevents(Ib,20) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end



for i = 1:(s11(1,1)/2)-1
            
        x = i_matrix_11(i,1);
        y = i_matrix_11(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,21);
            group_sr(j,1) = Pevents(j,22);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,22) = B;
            Pevents(Ib,22) = 0;
            
            else
                
            Pevents(Ib,22) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s12(1,1)/2)-1
            
        x = i_matrix_11(i,1);
        y = i_matrix_11(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,23);
            group_sr(j,1) = Pevents(j,24);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,24) = B;
            Pevents(Ib,24) = 0;
            
            else
                
            Pevents(Ib,24) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s13(1,1)/2)-1
            
        x = i_matrix_13(i,1);
        y = i_matrix_13(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,25);
            group_sr(j,1) = Pevents(j,26);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,26) = B;
            Pevents(Ib,26) = 0;
            
            else
                
            Pevents(Ib,26) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s14(1,1)/2)-1
            
        x = i_matrix_14(i,1);
        y = i_matrix_14(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,27);
            group_sr(j,1) = Pevents(j,28);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,28) = B;
            Pevents(Ib,28) = 0;
            
            else
                
            Pevents(Ib,28) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s15(1,1)/2)-1
            
        x = i_matrix_15(i,1);
        y = i_matrix_15(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,29);
            group_sr(j,1) = Pevents(j,30);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,30) = B;
            Pevents(Ib,30) = 0;
            
            else
                
            Pevents(Ib,30) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s16(1,1)/2)-1
            
        x = i_matrix_16(i,1);
        y = i_matrix_16(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,31);
            group_sr(j,1) = Pevents(j,32);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,32) = B;
            Pevents(Ib,32) = 0;
            
            else
                
            Pevents(Ib,32) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s17(1,1)/2)-1
            
        x = i_matrix_17(i,1);
        y = i_matrix_17(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,33);
            group_sr(j,1) = Pevents(j,34);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,34) = B;
            Pevents(Ib,34) = 0;
            
            else
                
            Pevents(Ib,34) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end

for i = 1:(s18(1,1)/2)-1
            
        x = i_matrix_18(i,1);
        y = i_matrix_18(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,35);
            group_sr(j,1) = Pevents(j,36);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,36) = B;
            Pevents(Ib,36) = 0;
            
            else
                
            Pevents(Ib,36) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s19(1,1)/2)-1
            
        x = i_matrix_19(i,1);
        y = i_matrix_19(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,37);
            group_sr(j,1) = Pevents(j,38);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,38) = B;
            Pevents(Ib,38) = 0;
            
            else
                
            Pevents(Ib,38) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s20(1,1)/2)-1
            
        x = i_matrix_20(i,1);
        y = i_matrix_20(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,39);
            group_sr(j,1) = Pevents(j,40);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,40) = B;
            Pevents(Ib,40) = 0;
            
            else
                
            Pevents(Ib,40) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s21(1,1)/2)-1
            
        x = i_matrix_21(i,1);
        y = i_matrix_21(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,41);
            group_sr(j,1) = Pevents(j,42);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,42) = B;
            Pevents(Ib,42) = 0;
            
            else
                
            Pevents(Ib,42) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s22(1,1)/2)-1
            
        x = i_matrix_22(i,1);
        y = i_matrix_22(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,43);
            group_sr(j,1) = Pevents(j,44);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,44) = B;
            Pevents(Ib,44) = 0;
            
            else
                
            Pevents(Ib,44) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end


for i = 1:(s23(1,1)/2)-1
            
        x = i_matrix_23(i,1);
        y = i_matrix_23(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,45);
            group_sr(j,1) = Pevents(j,46);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,46) = B;
            Pevents(Ib,46) = 0;
            
            else
                
            Pevents(Ib,46) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end

for i = 1:(s24(1,1)/2)-1
            
        x = i_matrix_24(i,1);
        y = i_matrix_24(i,2);
    
    for j = x:y
        
            group_er(j,1) = Pevents(j,47);
            group_sr(j,1) = Pevents(j,48);
    
            [A, Ia] = max(group_er);
            [B, Ib] = max(group_sr);
            
            if Ia ~= Ib
            
            Pevents(Ia,48) = B;
            Pevents(Ib,48) = 0;
            
            else
                
            Pevents(Ib,48) = B;
            
            end
                  
    end
    
            group_er = zeros(14246,1);
            group_sr = zeros(14246,1);
    
end

     
% Calculates X factor of the index. Rain index is time consumin, it was
% runned once and saved.

% Age = zeros(14246,1);
% % Rain_index = zeros(14246-19,48);
% i_matrix_age = zeros(14246-19,1);
load('Rain_index');
load('i_matrix_age.mat');

% for i = 1:14246-19
%     
% i_matrix_age(i,1) = i;
% i_matrix_age(i,2) = i+19;
% 
% end

% Finds significant rain events for previous 20 days

% m_0 = 1:2:48;
% n_0 = 2:2:48;
% 
% for k = 22:24
%     
%     m = m_0(k);
%     n = n_0(k);
% 
% for i = 1:14246-19
%     
%        x = i_matrix_age(i,1);
%        y = i_matrix_age(i,2);
%     
%             for j = x:y
%     
%                 Age(j,1) = Pevents(j,n);
%                 [r, Ic] = max(Age);
%         
%                 if r == 0
%             
%                 Rain_index(i,m) = r;
%                 Rain_index(i,n) = i;
%         
%                 else 
%             
%                 Rain_index(i,m) = r;
%                 Rain_index(i,n) = Ic;
%                 
%                 end
%             
%             end   
%         Age = zeros(14640,1);
% end
% 
% end
    
% % Calcualtes factor "X" of the index

X = zeros(14246-19,48);
t = 0;


m_0 = 1:2:48;
n_0 = 2:2:48;

for k = 1:24
    
    m = m_0(k);
    n = n_0(k);

for i = 1:14246-19
    
    Id = Rain_index(i,n);
    r = Rain_index(i,m);
    p = i_matrix_age(i,1) + 20;

    
    for j = p:p
            
        t = j - Id;
    
        X(j,m) = (t^1.3)/((t^1.3) + (r) - (2));
    
        t = 0;
        
    end
   
end

end

X( :, all( ~any( X ), 1 ) ) = [];


% % Calcualtes factor F

F = zeros(14246,24);

for j = 1:24

    for i = 21:14246-19

    xf = X(i,j);
    
    F(i,j) = ((41*xf^2) + (xf))/((40*xf^2) + (xf) + (1));
    
    
    end

end


% Calculates drought factor

DF = zeros(14246,24);

A = zeros(14246,24);
B = zeros(14246,24);
C = zeros(14246,24);


for j = 1:24
    
for i = 21:14246

    smd = SMD(i,j);
    f = F(i,j);
    
    A(i,j) = (smd+30)/40;
    B(i,j) = 1 - exp(-A(i));
    C(i,j) = 10.5 * B(i,j) * f;
    
    DF(i,j) = 10.5 * ((1 - exp(-(smd+30)/40))) * f;

end

end














    
    
   
        

        
        
    