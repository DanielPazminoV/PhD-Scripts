% Calculates t-test matrix of anomalies for bushfires events 

% Clears the work space for a new run of the script

clear all 
close all

% Loads the anomalies and bushfire records files and determines
% the size of the files

SST_anomalis = ncread('HadISST_sst_anom_1960_2011.nc','sst');
load('b_records_1961_2011.mat')
load('Avg_per_season_djf.mat')
n = length(b_records_1961_2011);
W_size_1 = size(SST_anomalis); 

% Prealocates memory for the bushfire records with a zeros matrix.

records_n = zeros(n,1);

% Modifies the time steps of the anomalies file to select dates close to
% original bushfire dates (day zero) (d-1, d-2, d-3...).

 for i = 1:n
    
    records_n(i,1) = b_records_1961_2011(i,1)-0;
    
 end
 
 % Preallocates memory for the bushfire days anomalies with a zeros matrix.
 
 SST_anomalis_n = zeros(360,180,n);
 
 % Compares the time steps of the bushfire records with those of 
 % the anomalies file saving the anomalies of bushfire dates in 
 % a separete matrix.
 
 for j = 1:1:n

             k = records_n(j,1);
     
             SST_anomalis_n(:,:,j) = SST_anomalis(:,:,k);
             
 end
 
 % Calcualtes average anomalies of all bushfire days
 
 Total_average_anomalies = mean(SST_anomalis_n,3);
 
 % Here starts the lines for the t-test matrix
 
 % The value of N in the calculation of the t statistic should be 45, since
 % this is the number of bushfire seasons evaluated.
 
 N = 18;
 
 % Calculates standar deviation
 
 % Prealocates memory for the sum parameter of the equation
 
 sum_i = zeros(360,180);
 sum_j = zeros(360,180);
 
 % Makes the sum in the square root of the standar deviation equation
 
 for l = 1:N
    
     sum_i = ((Avg_per_season_djf(:,:,l) - Total_average_anomalies)).^2;
     sum_j = sum_j + sum_i;
     
 end
 
 % Prealocates memory for division parameter
 
  sum_m = zeros(360,180);
  
  % Makes the division standar deviation equation
 
  for r = 1:360
     for s = 1:180
         
         t = sum_j(r,s);
         
         sum_m(r,s) = t/N-1;
         
     end
  end
 
  
  % Preallocates memory for square root parameter of the standar deviation
  % equation
  
   sum_n = zeros(360,180);
   
   % sum_n is the standar deviation value
  
  for u = 1:360
     for v = 1:180
         
         w = sum_m(u,v);
         
         sum_n(u,v) = w^0.5;
         
     end
 end

% Calculation of t matrix

% Square root of N

sqr_N = (N-1)^0.5;

% Preallocates memory for division in deminator of t equation

  div_t = zeros(360,180);
  
 % Executes the division in denominator of t equation  

  for x = 1:360
     for y = 1:180
         
         z = sum_n(x,y);
         div_t(x,y) = z/sqr_N;
         
     end
  end
     
  % Preallocates memory for T_matrix (result matrix)
  
  T_matrix_djf = zeros(360,180);

  % Executes the devision to din T_matrix
  
   for a = 1:360
     for b = 1:180
         
         T_matrix_djf(a,b) = Total_average_anomalies(a,b)/div_t(a,b);

     end
   end
  
  % Filters values outside the critical t value (-+ 1.96 for 143 degrees of
  % freedom)
  
  
  for c = 1:360
      for d = 1:180
          
          e =  T_matrix_djf(c,d);
          
          if e > 2.101
              
              T_matrix_djf(c,d) = T_matrix_djf(c,d);
              
              elseif e < -2.101
                  
              T_matrix_djf(c,d) = T_matrix_djf(c,d);
              
          else
              
              T_matrix_djf(c,d) = NaN; 
              
          end 
          
      end
  end
  
  save('T_matrix_djf.mat','T_matrix_djf')
  
  
  
  

