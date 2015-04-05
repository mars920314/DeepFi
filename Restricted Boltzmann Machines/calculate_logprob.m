function [logprob] = calculate_logprob(vishid,hidbiases,visbiases,logZ,batchdata);

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
% logZ -- log of the partition function 
% batchdata -- the data that is divided into batches (numcases numdims numbatches)

[numcases numdims numbatches]=size(batchdata);

%%%%% Estimate Test Log-Probability
 data = [];
 for ii=1:numbatches
   data = [data; batchdata(:,:,ii)];
 end
 numcases = size(data,1);

 pd = data*visbiases' + sum(log(1+exp(ones(numcases,1)*hidbiases + data*vishid)),2);
 logprob = sum(pd)/numcases  - logZ;



