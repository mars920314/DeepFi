csi_trace = read_bf_file('x56');    %

numtot=300;     %
numall=400;     %
test_csi=zeros(3,30,numall-numtot);
test_time_csi=zeros(3,30,numall-numtot);
for i=(numtot+1):numall
    csi_entry = csi_trace{i};
    csientry = get_scaled_csi(csi_entry);
    perm = csi_entry.perm;
    for k=1:3
        if perm(k)==1
            test_csi(1,:,i-numtot)=csientry(1,perm(k),:);
            test_time_csi(1,:,i-numtot)=ifft(test_csi(1,:,i-numtot));
        elseif perm(k)==2
            test_csi(2,:,i-numtot)=csientry(1,perm(k),:);
            test_time_csi(2,:,i-numtot)=ifft(test_csi(2,:,i-numtot));
        elseif perm(k)==3
            test_csi(3,:,i-numtot)=csientry(1,perm(k),:);
            test_time_csi(3,:,i-numtot)=ifft(test_csi(3,:,i-numtot));
        end
    end
end

numcases=5;     %
numdims=30;
test_numbatches=(numall-numtot)/numcases;
testbatchdata = zeros(numcases, numdims, test_numbatches);
for b=1:test_numbatches
    for c=1:numcases
%         testbatchdata(c,:,b) = test_csi(1,:,(b-1)*numcases+c);
        testbatchdata(c,:,b) = (abs(squeeze(test_csi(1,:,(b-1)*numcases+c))));
    end
end
testbatchdata=testbatchdata/max(max(max(testbatchdata)));
save testbatchdata56 testbatchdata;     %
clear all
fprintf(1,'finished');