function E=getE(dataname,traindataname)

load(dataname);
load (traindataname);
% load mnistvh;
% load mnisthp;
% load mnisthp2;
% load mnistpo;

[numcases numdims numbatches]=size(batchdata);
N=numcases;
err=0;
E=0;
for batch = 1:numbatches
  dataori = [batchdata(:,:,batch)];
  data = [dataori ones(N,1)];
  w1probsori = 1./(1 + exp(-data*w1)); w1probs = [w1probsori  ones(N,1)];
  w2probsori = 1./(1 + exp(-w1probs*w2)); w2probs = [w2probsori ones(N,1)];
  w3probsori = 1./(1 + exp(-w2probs*w3)); w3probs = [w3probsori  ones(N,1)];
  w4probsori = w3probs*w4; w4probs = [w4probsori  ones(N,1)];
  w5probsori = 1./(1 + exp(-w4probs*w5)); w5probs = [w5probsori  ones(N,1)];
  w6probsori = 1./(1 + exp(-w5probs*w6)); w6probs = [w6probsori  ones(N,1)];
  w7probsori = 1./(1 + exp(-w6probs*w7)); w7probs = [w7probsori  ones(N,1)];
  dataout = 1./(1 + exp(-w7probs*w8));
  save all;
  %   err = err +  1/N*sum(sum( (data(:,1:end-1)-dataout).^2 ));
  DE=sum(sum(data*w1*w1probsori'))-sum(sum(w1probsori*hidrecbiases'))-sum(sum(dataori*visbiases'));
%   if DE<0
%       fprintf(1,'DE<0');
%   end
  E=E-DE;
  E=E-sum(sum(-w1probs*w2*w2probsori'))-sum(sum(w2probsori*penrecbiases'))-sum(sum(w1probsori*hidgenbiases'));
end
 err=err/numbatches/numcases;
 E=E/numbatches;
 fprintf(1,'squared error: %6.3f ,%s of %s \t \t \n',E, dataname, traindataname);
