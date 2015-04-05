num=0;
csistd=zeros(3,51);
rssstd=zeros(3,51);
for j=1:3
for i=1:99
 filename=['.\data\3lab' num2str(j) num2str(i)];
 if(exist(filename)==2)
     num=num+1;
% filename1=['.\data\3lat31'];
% filename2=['.\data\3lab3' num2str(num)];
NN=550;
MM=600;
% N=00;
% M=1000;
% NN=00;
% MM=1000;
csi1=zeros(3,30,MM-NN);
time_csi1=zeros(3,30,MM-NN);
csi_trace = read_bf_file(filename);
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
%     hold on
%     plot(csi1(1,:,i-NN),'r');
end

rss=zeros(3,MM-NN);
for an=1:3
    for channel=1:30
        csistd(an,num)=mean(std(csi1(an,channel,:))/mean(csi1(an,channel,:)));
    end
    for pk=1:MM-NN
        rss(an,pk)=norm(csi1(an,:,pk))^2;
    end
    rssstd(an,num)=std(rss(an,:))/mean(rss(an,:));
end

 end
end
end
ecdf([csistd(1,:) csistd(2,:) csistd(3,:)]);
hold on
ecdf([rssstd(1,:) rssstd(2,:) rssstd(3,:)]);