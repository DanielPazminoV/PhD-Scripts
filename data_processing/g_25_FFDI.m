clear all
close all

% Identifies days with FFDI greater than 50

% load('FFDI_20CR_bc')
% load('FFDI_original_20CR')
load('FFDI_seasonal_djf')

size = size(FFDI_seasonal_djf);
n = size(1,1);


% FFDI_20CR_bc_g25 = zeros(n,1);
% 
% for i = 1:n
%     
%         if FFDI_20CR_bc(i) > 25 
%         
%             FFDI_20CR_bc_g25(i) = 1;
%         
%         elseif FFDI_20CR_bc(i) < 25 
%         
%             FFDI_20CR_bc_g25(i) = 0;
%         
%         end       
% end
% 
% FFDI_original_20CR_g25 = zeros(n,1);
% 
% for i = 1:n
%     
%         if FFDI_original_20CR(i) > 25 
%         
%             FFDI_original_20CR_g25(i) = 1;
%         
%         elseif FFDI_original_20CR(i) < 25 
%         
%             FFDI_original_20CR_g25(i) = 0;
%         
%         end       
% end

FFDI_20cr_g25 = zeros(n,1);

for i = 1:n
    
        if FFDI_seasonal_djf(i) > 25 
        
            FFDI_20cr_g25(i) = 1;
        
        elseif FFDI_seasonal_djf(i) < 25 
        
            FFDI_20cr_g25(i) = 0;
        
        end       
end

% save FFDI_20CR_bc_g25
% save FFDI_original_20CR_g25
save FFDI_20cr_g25





