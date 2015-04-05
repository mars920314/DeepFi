function [logZZ_est, logZZ_est_up, logZZ_est_down] = ...
             RBM_AIS(vishid,hidbiases,visbiases,numruns,beta,batchdata);

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

% vishid    -- a matrix of RBM weights [numvis, numhid]
% hidbiases -- a row vector of hidden  biases [1 numhid]
% visbiases -- a row vector of visible biases [1 numvis]
% numruns   -- number of AIS runs
% beta      -- a row vector containing beta's
% batchdata -- the data that is divided into batches (numcases numdims numbatches)

% Note: The training data, batchdata, is only used to create base-rate model.
% If batchdata is not present, initial distribution will be uniform.  
% Thanks to Nicolas Le Roux for pointing out ways of making this code faster. 

 close all
%  figure('Position',[100,600,500,200]);
 figure(2)
  hold on
  xlabel('beta','fontsize',14)
  ylabel('Variance of log weights','fontsize',14)

   [numdims numhids]=size(vishid);
 if(nargin>5)
 %%% Initialize biases of the base rate model by ML %%%%%%%%%%%%%%%%%%%%%%%
   base_rate 
   visbiases_base = log_base_rate';
 else
   visbiases_base = 0*visbiases;
 end  

 numcases = numruns; 

 %%%%%%%%%% RUN AIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 visbias_base = repmat(visbiases_base,numcases,1); %biases of base-rate model.  
 hidbias = repmat(hidbiases,numcases,1); 
 visbias = repmat(visbiases,numcases,1);

 %%%% Sample from the base-rate model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 logww = zeros(numcases,1);
 negdata = repmat(1./(1+exp(-visbiases_base)),numcases,1);  
 negdata = negdata > rand(numcases,numdims);
 logww  =  logww - (negdata*visbiases_base' + numhids*log(2));

 Wh = negdata*vishid + hidbias; 
 Bv_base = negdata*visbiases_base';
 Bv = negdata*visbiases';   
 tt=1; 

 %%% The CORE of an AIS RUN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for bb = beta(2:end-1);  
%   fprintf(1,'beta=%d\r',bb);
   tt = tt+1; 

   expWh = exp(bb*Wh);
   logww  =  logww + (1-bb)*Bv_base + bb*Bv + sum(log(1+expWh),2);

   poshidprobs = expWh./(1 + expWh);
   poshidstates = poshidprobs > rand(numcases,numhids);

   negdata = 1./(1 + exp(-(1-bb)*visbias_base - bb*(poshidstates*vishid' + visbias)));
   negdata = negdata > rand(numcases,numdims);

   if rem(tt,500)==0
      figure(1)
       mnistdisp(negdata(1:10,:)');

      figure(2)
       plot(tt/length(beta),var(logww(:)),'b*')
       hold on
       drawnow;
   end 

   Wh      = negdata*vishid + hidbias;
   Bv_base = negdata*visbiases_base';
   Bv      = negdata*visbiases';

   expWh = exp(bb*Wh);
   logww  =  logww - ((1-bb)*Bv_base + bb*Bv + sum(log(1+expWh),2));

 end 

 expWh = exp(Wh);
 logww  = logww +  negdata*visbiases' + sum(log(1+expWh),2);

 %%% Compute an estimate of logZZ_est +/- 3 standard deviations.   
 r_AIS = logsum(logww(:)) -  log(numcases);  
 aa = mean(logww(:)); 
 logstd_AIS = log (std(exp ( logww-aa))) + aa - log(numcases)/2;   
 %%% Same as computing  logstd_AIS = log(std(exp(logww(:)))/sqrt(numcases));  

 logZZ_base = sum(log(1+exp(visbiases_base))) + (numhids)*log(2); 
 logZZ_est = r_AIS + logZZ_base;
 logZZ_est_up = logsum([log(3)+logstd_AIS;r_AIS]) + logZZ_base;
 logZZ_est_down = logdiff([(log(3)+logstd_AIS);r_AIS]) + logZZ_base;
 if ~isreal(logZZ_est_down)
  logZZ_lat_comp_down = 0;
 end
save RBM
