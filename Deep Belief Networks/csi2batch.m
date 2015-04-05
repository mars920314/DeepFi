load csidata;

%10*30*50

numcases=10;
numdims=30;
numbatches=numtot/numcases;
batchdata = zeros(numcases, numdims, numbatches);
for b=1:numbatches
    for c=1:numcases
        batchdata(c,:,b) = csi(1,:,(b-1)*numcases+c);
    end
end
test_numbatches=(600-numtot)/numcases;
testbatchdata = zeros(numcases, numdims, test_numbatches);
for b=1:test_numbatches
    for c=1:numcases
        testbatchdata(c,:,b) = test_csi(1,:,(b-1)*numcases+c);
    end
end

save batchdata batchdata testbatchdata;
clear all