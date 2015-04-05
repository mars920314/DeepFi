csi_trace = read_bf_file('x55');

numtot=400;
csi=zeros(3,30,numtot);
time_csi=zeros(3,30,numtot);
for i=1:numtot
    csi_entry = csi_trace{i};
    csientry = get_scaled_csi(csi_entry);
    perm = csi_entry.perm;
    for k=1:3
        if perm(k)==1
            csi(1,:,i)=csientry(1,perm(k),:);
            time_csi(1,:,i)=ifft(csi(1,:,i));
        elseif perm(k)==2
            csi(2,:,i)=csientry(1,perm(k),:);
            time_csi(2,:,i)=ifft(csi(2,:,i));
        elseif perm(k)==3
            csi(3,:,i)=csientry(1,perm(k),:);
            time_csi(3,:,i)=ifft(csi(3,:,i));
        end
    end
end

numcases=5;
numdims=30;
numbatches=numtot/numcases;
batchdata = zeros(numcases, numdims, numbatches);
for b=1:numbatches
    for c=1:numcases
%         batchdata(c,:,b) = csi(1,:,(b-1)*numcases+c);
        batchdata(c,:,b) = (abs(squeeze(csi(1,:,(b-1)*numcases+c))));
    end
end
batchdata=batchdata/max(max(max(batchdata)));
save batchdata55 batchdata;
clear all