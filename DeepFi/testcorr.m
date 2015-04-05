clear
figure;
num=2
filename1=['.\corr\h11'];
filename2=['.\corr\h1' num2str(num)];
% filename1=['.\data\3lat31'];
% filename2=['.\data\3lab3' num2str(num)];
errall=zeros(1,20);
for pk=1:20
an=2;
N=50;
M=N+10*pk;
NN=350;
MM=NN+10*pk;
% N=00;
% M=1000;
% NN=00;
% MM=1000;
csi1=zeros(3,30,MM-NN);
time_csi1=zeros(3,30,MM-NN);
csi2=zeros(3,30,M-N);
time_csi2=zeros(3,30,M-N);
csi_trace = read_bf_file(filename1);
for i=(NN+1):MM
    csi_entry = csi_trace{i};
    csientry = get_scaled_csi(csi_entry);
    perm = csi_entry.perm;
    for k=1:3
        if perm(k)==1
            csi1(1,:,i-NN)=abs(csientry(1,perm(k),:));
%             csi1(1,:,i-N)=csi1(1,:,i-N)-min(csi1(1,:,i-N));
            time_csi1(1,:,i-NN)=ifft(csi1(1,:,i-NN));
        elseif perm(k)==2
            csi1(2,:,i-NN)=abs(csientry(1,perm(k),:));
%             csi1(2,:,i-N)=csi1(2,:,i-N)-min(csi1(2,:,i-N));
            time_csi1(2,:,i-NN)=ifft(csi1(2,:,i-NN));
        elseif perm(k)==3
            csi1(3,:,i-NN)=abs(csientry(1,perm(k),:));
%             csi1(3,:,i-N)=csi1(3,:,i-N)-min(csi1(3,:,i-N));
            time_csi1(3,:,i-NN)=ifft(csi1(3,:,i-NN));
        end
    end
    hold on
    plot(csi1(an,:,i-NN),'r');
end
csi_trace = read_bf_file(filename2);
for i=(N+1):M
    csi_entry = csi_trace{i};
    csientry = get_scaled_csi(csi_entry);
    perm = csi_entry.perm;
    for k=1:3
        if perm(k)==1
            csi2(1,:,i-N)=abs(csientry(1,perm(k),:));
%             csi2(1,:,i-N)=csi2(1,:,i-N)-min(csi2(1,:,i-N));
            time_csi2(1,:,i-N)=ifft(csi2(1,:,i-N));
        elseif perm(k)==2
            csi2(2,:,i-N)=abs(csientry(1,perm(k),:));
%             csi2(2,:,i-N)=csi2(2,:,i-N)-min(csi2(2,:,i-N));
            time_csi2(2,:,i-N)=ifft(csi2(2,:,i-N));
        elseif perm(k)==3
            csi2(3,:,i-N)=abs(csientry(1,perm(k),:));
%             csi2(3,:,i-N)=csi2(3,:,i-N)-min(csi2(3,:,i-N));
            time_csi2(3,:,i-N)=ifft(csi2(3,:,i-N));
        end
    end
    hold on
    plot(csi2(an,:,i-N),'b');
end
err=0;

for i=1:(M-N)
    err=err+corr(csi1(an,:,i)',csi2(an,:,i)');
end
errall(pk)=err/(M-N);
end