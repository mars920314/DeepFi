function batchdata=getonebatchdata(filename,N,M,an)
% csi_trace = read_bf_file(filename);
% csi=zeros(3,30,M-N);
% time_csi=zeros(3,30,M-N);
% % figure;
% for i=(N+1):M
%     csi_entry = csi_trace{i};
%     csientry = get_scaled_csi(csi_entry);
%     perm = csi_entry.perm;
%     for k=1:3
%         if perm(k)==1
%             csi(1,:,i-N)=csientry(1,perm(k),:);
%             time_csi(1,:,i-N)=ifft(csi(1,:,i-N));
%         elseif perm(k)==2
%             csi(2,:,i-N)=csientry(1,perm(k),:);
%             time_csi(2,:,i-N)=ifft(csi(2,:,i-N));
%         elseif perm(k)==3
%             csi(3,:,i-N)=csientry(1,perm(k),:);
%             time_csi(3,:,i-N)=ifft(csi(3,:,i-N));
%         end
%     end
% %     hold on
% %     plot((abs(squeeze(csi(1,:,i-N)))),'r');
% end

load(filename);
csi_tmp=csi;
csi=zeros(3,30,M-N);
csi(:,:,:)=csi_tmp(:,:,[N:M-1]);

numcases=5; %how to group data
numdims=30; %visible nodes
numbatches=(M-N)/numcases;
batchdata = zeros(numcases, numdims, numbatches);
for b=1:numbatches
    for c=1:numcases
        batchdata(c,:,b) = [(abs(squeeze(csi(an,:,(b-1)*numcases+c))))];
%         batchdata(c,:,b) = [(sum(abs(squeeze(csi(1,[1:5],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(1,[6:10],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(1,[11:15],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(1,[16:20],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(1,[21:25],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(1,[26:30],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(2,[1:5],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(2,[6:10],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(2,[11:15],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(2,[16:20],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(2,[21:25],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(3,[26:30],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(3,[1:5],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(3,[6:10],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(3,[11:15],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(3,[16:20],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(3,[21:25],(b-1)*numcases+c))))) (sum(abs(squeeze(csi(3,[26:30],(b-1)*numcases+c)))))];
    end
end
batchdata=batchdata/max(max(max(batchdata)));