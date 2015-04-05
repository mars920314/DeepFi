clc
clear all
for jj=2:2
for j=73:75
filename=['.\data\3lab' num2str(jj) num2str(j)];
% filename=['.\data\x' num2str(j)];
if(exist(filename)==2)
M=1000;
N=1;
csi_trace = read_bf_file(filename);
csi=zeros(3,30,M-N);
for i=(N+1):M
    csi_entry = csi_trace{i};
    csientry = get_scaled_csi(csi_entry);
    perm = csi_entry.perm;
    for k=1:3
        if perm(k)==1
            csi(1,:,i-N)=csientry(1,perm(k),:);
%             time_csi(1,:,i-N)=ifft(csi(1,:,i-N),point);
%             time_csi_abs(1,:,i-N)=abs(time_csi(1,:,i-N));
        elseif perm(k)==2
            csi(2,:,i-N)=csientry(1,perm(k),:);
%             time_csi(2,:,i-N)=ifft(csi(2,:,i-N),point);
%             time_csi_abs(2,:,i-N)=abs(time_csi(2,:,i-N));
        elseif perm(k)==3
            csi(3,:,i-N)=csientry(1,perm(k),:);
%             time_csi(3,:,i-N)=ifft(csi(3,:,i-N),point);
%             time_csi_abs(3,:,i-N)=abs(time_csi(3,:,i-N));
        end
    end
end
csi=squeeze(csi);
save(filename,'csi');
end
end
end