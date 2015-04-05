function [logZZ_true] = calculate_true_partition(vishid,hidbiases,visbiases);

% Version 1.000
%
% Code provided by Ruslan Salakhutdinov
%
% Permission is granted for anyone to copy, use, modify, or distribute this
% program and accompanying programs and documents for any purpose, provided
% this copyright notice is retained and prominently displayed, along with
% a note saying that the original programs are available from our
% web page.
% The programs and documents are distributed without any warranty, express or
% implied.  As the programs were written for research purposes only, they have
% not been tested to the degree that would be advisable in any important
% application.  All use of these programs is entirely at the user's own risk.

[numdims numhids]=size(vishid);
log_prob_vv = zeros(2^numhids,1);

mm = uint8([0; 1]);
for jj=1:numhids-1  
  mm1 = uint8([zeros(length(mm),1); ones(length(mm),1)]); 
  mm = [mm; mm]; 
  mm = [ mm1 mm];
end 
hh = double(mm); clear mm 
log_prob_vv = hh*hidbiases' + sum(log(1+exp(ones(2^numhids,1)*visbiases + hh*vishid')),2);
logZZ_true = logsum(log_prob_vv); 
clear log_prob_vv hh 


