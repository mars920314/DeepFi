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


% This program trains a tiny RBM model using Contrastive Divergence,  
% calculates the log-partition function by brute force and then estimates
% the value of the partition function by running AIS.

clear all
close all

fprintf(1,'Converting Raw files into Matlab format \n');
converter;%---------------------%
%%
fprintf(1,'\nTraining a toy RBM model using CD3. \n');

makebatches;%---------------------%
save batchdata batchdata testbatchdata;
clear all;
load batchdata;
%%
[numcases numdims numbatches]=size(batchdata);
maxepoch=10; 
numhid=15; CD=3; 
restart=1;
rbm;%---------------------%
save mnistvh vishid hidbiases visbiases;
clear all;
load mnistvh;
%%
fprintf(1,'\nCalculating the true log-partition function by brute force.\n');
[logZZ_true] = calculate_true_partition(vishid,hidbiases,visbiases);%---------------------%
loglik_test_true = calculate_logprob(vishid,hidbiases,visbiases,logZZ_true,testbatchdata);%---------------------%

fprintf(1,'True log-partition function: %f\n', logZZ_true);
fprintf(1,'Average log-prob on the test data: %f\n', loglik_test_true);
fprintf(1,'finish');
%%
fprintf(1,'\nEstimating partition function by running 100 AIS runs.\n');
beta = [0:1/1000:0.5 0.5:1/10000:0.9 0.9:1/100000:1.0];
numruns = 100;

[logZZ_est, logZZ_est_up, logZZ_est_down] = ...
             RBM_AIS(vishid,hidbiases,visbiases,numruns,beta,batchdata);%---------------------%

loglik_test_est = calculate_logprob(vishid,hidbiases,visbiases,logZZ_est,testbatchdata);%---------------------%


fprintf(1,'\nEstimated  log-partition function (+/- 3 std): %f (%f %f)\n', logZZ_est,logZZ_est_down,logZZ_est_up);
fprintf(1,'Average estimated log-prob on the test data: %f\n', loglik_test_est);
fprintf(1,'True log-partition function: %f\n', logZZ_true);
fprintf(1,'Average log-prob on the test data: %f\n', loglik_test_true);

