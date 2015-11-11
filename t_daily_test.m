% Calculates t-test matrix of anomalies for bushfires events 

% Clears the work space for a new run of the script

clear all 
close all

% Loads the anomalies and bushfire records files and determines
% the size of the files

Air_anomalis = ncread('air.anom.1961-2011.nc','air');
load('BE_records.mat')
n = length(BE_records);
W_size_1 = size(Air_anomalis); 

% Prealocates memory for the bushfire records with a zeros matrix.

Bushfire_records_n = zeros(n,1);

% Modifies the time steps of the anomalies file to select dates close to
% original bushfire dates (day zero) (d-1, d-2, d-3...).

 for i = 1:n
    
    Bushfire_records_n(i,1) = BE_records(i,1)-0;
    
 end
 
 % Preallocates memory for the bushfire days anomalies with a zeros matrix.
 
 Air_anomalis_n = zeros(180,91,n);
 
 % Compares the time steps of the bushfire records with those of 
 % the anomalies file saving the anomalies of bushfire dates in 
 % a separete matrix.
 
 for j = 1:1:n

             k = Bushfire_records_n(j,1);
     
             Air_anomalis_n(:,:,j) = Air_anomalis(:,:,k);
             
 end
         
 
 % Reduces the selected anomalies matrix to 3 dimensions. 
 % Determines the size of the final file
 
%  Air_anomalis_n = squeeze(Air_anomalis_n(:,:,1,:));
 W_size_2 = size(Air_anomalis_n);
 

 % Calcualtes average anomalies of all bushfire days
 
 Total_average_anomalies = mean(Air_anomalis_n,3);
 
 % Here starts the lines for the t-test matrix
 
 % Calculates standar deviation
 
 % Prealocates memory for the sum parameter of the equation
 
 sum_i = zeros(180,91);
 sum_j = zeros(180,91);
 
 % Makes the sum in the square root of the standar deviation equation
 
 for l = 1:n
    
     sum_i = ((Air_anomalis_n(:,:,l) - Total_average_anomalies)).^2;
     sum_j = sum_j + sum_i;
     
 end
 
 % Prealocates memory for division parameter
 
  sum_m = zeros(180,91);
  
  % Makes the division standar deviation equation
 
  for r = 1:180
     for s = 1:91
         
         t = sum_j(r,s);
         
         sum_m(r,s) = t/n-1;
         
     end
  end
 
  
  % Preallocates memory for square root parameter of the standar deviation
  % equation
  
   sum_n = zeros(180,91);
   
   % sum_n is the standar deviation value
  
  for u = 1:180
     for v = 1:91
         
         w = sum_m(u,v);
         
         sum_n(u,v) = w^0.5;
         
     end
 end

% Calculation of t matrix

% Square root of N

sqr_N = (n)^0.5;

% Preallocates memory for division in deminator of t equation

  div_t = zeros(180,91);
  
 % Executes the division in deminator of t equation  

  for x = 1:180
     for y = 1:91
         
         z = sum_n(x,y);
         div_t(x,y) = z/sqr_N;
         
     end
  end
     
  % Preallocates memory for T_matrix (result matrix)
  
  T_matrix_zero = zeros(180,91);

  % Executes the devision to din T_matrix
  
   for a = 1:180
     for b = 1:91
         
         T_matrix_zero(a,b) = Total_average_anomalies(a,b)/div_t(a,b);

     end
   end
  
  % Filters values outside the critical t value (-+ 1.96 for 134 degrees of
  % freedom)
  
  
  for c = 1:180
      for d = 1:91
          
          e =  T_matrix_zero(c,d);
          
          if e > 2.052
              
              T_matrix_zero(c,d) = T_matrix_zero(c,d);
              
              elseif e <-2.052
                  
              T_matrix_zero(c,d) = T_matrix_zero(c,d);
              
          else
              
              T_matrix_zero(c,d) = NaN; 
              
          end 
          
      end
  end
  
  
  save('T_matrix_zero.mat','T_matrix_zero')
  
  
  
  

