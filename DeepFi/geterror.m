function err=geterror(dataname,traindataname)

load(dataname);
load (traindataname);

[numcases numdims numbatches]=size(batchdata);
N=numcases;
err=0;
for batch = 1:numbatches
  data = [batchdata(:,:,batch)];
  data = [data ones(N,1)];
  w1probs = 1./(1 + exp(-data*w1)); w1probs = [w1probs  ones(N,1)];
  w2probs = 1./(1 + exp(-w1probs*w2)); w2probs = [w2probs ones(N,1)];
  w3probs = 1./(1 + exp(-w2probs*w3)); w3probs = [w3probs  ones(N,1)];
  w4probs = w3probs*w4; w4probs = [w4probs  ones(N,1)];
  w5probs = 1./(1 + exp(-w4probs*w5)); w5probs = [w5probs  ones(N,1)];
  w6probs = 1./(1 + exp(-w5probs*w6)); w6probs = [w6probs  ones(N,1)];
  w7probs = 1./(1 + exp(-w6probs*w7)); w7probs = [w7probs  ones(N,1)];
  dataout = 1./(1 + exp(-w7probs*w8));
%   err=err+sum(sum(dataori.*dataout))/(sqrt(sum(sum(dataori.^2)))*sqrt(sum(sum(dataout.^2))));
  err = err +  1/N*sum(sum( (data(:,1:end-1)-dataout).^2 ));
end
 err=err/numbatches;
 fprintf(1,'squared error: %6.3f ,%s of %s \t \t \n',err, dataname, traindataname);