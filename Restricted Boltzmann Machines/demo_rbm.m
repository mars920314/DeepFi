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


% This program load CD25(500) model: an RBM trained using Contrastive Divergence
% with T=25, and estimates the value of the partition function by running AIS.
% Results on performance of this model, and details of training, can be found in: 
% @InProceedings{SalMurray08,
%  title =      "On the Quantitative Analysis of Deep Belief Networks",
%  author =     "Ruslan Salakhutdinov and Iain Murray",
%  booktitle =  "Proceedings of the International Conference on Machine
%                 Learning",
%  year =       "2008",
%  volume =     "25",
% }
%

clear all
close all

fprintf(1,'Converting Raw files into Matlab format \n');
converter;

makebatches;
fprintf(1,'\nEstimating partition function of large CD25(500) model by running 100 AIS runs.\n');
beta = [0:1/1000:0.5 0.5:1/10000:0.9 0.9:1/100000:1.0];
numruns = 100;
rand('state',30);
randn('state',30);

load mnistvh_CD25
[logZZ_est, logZZ_est_up, logZZ_est_down] = ...
             RBM_AIS(vishid,hidbiases,visbiases,numruns,beta,batchdata);

loglik_test_est = calculate_logprob(vishid,hidbiases,visbiases,logZZ_est,testbatchdata);

fprintf(1,'\nEstimated  log-partition function (+/- 3 std): %f (%f %f)\n', logZZ_est,logZZ_est_down,logZZ_est_up);
fprintf(1,'Average estimated log_prob on the test data: %f\n', loglik_test_est);


