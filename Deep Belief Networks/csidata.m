csi_trace = read_bf_file('x13');

numtot=500;
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
test_csi=zeros(3,30,600-numtot);
test_time_csi=zeros(3,30,600-numtot);
for i=numtot:600
    csi_entry = csi_trace{i};
    csientry = get_scaled_csi(csi_entry);
    perm = csi_entry.perm;
    for k=1:3
        if perm(k)==1
            test_csi(1,:,i)=csientry(1,perm(k),:);
            test_time_csi(1,:,i)=ifft(test_csi(1,:,i));
        elseif perm(k)==2
            test_csi(2,:,i)=csientry(1,perm(k),:);
            test_time_csi(2,:,i)=ifft(test_csi(2,:,i));
        elseif perm(k)==3
            test_csi(3,:,i)=csientry(1,perm(k),:);
            test_time_csi(3,:,i)=ifft(test_csi(3,:,i));
        end
    end
end
save csidata numtot csi time_csi test_csi test_time_csi;
clear all