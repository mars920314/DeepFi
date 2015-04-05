%test
clear all
close all
% clc
for ii=3:3
    for jj=6:6
        filename=['.\data\x' num2str(ii) num2str(jj)];
        if(exist(filename)==2)
        end
        batchdata=getbatchdata(filename,100,200);
        dataname=['testbatchdata'];
        save(dataname, 'batchdata');

        err=zeros(6,9);
        for i=1:6
            for j=1:9
                traindataname=['.\data\mnist_weights' num2str(i) num2str(j) '.mat'];
                if(exist(traindataname)==2)
                    err(i,j)=geterror(dataname,traindataname);
                end
            end
        end
        err
%         err<err(2,4)*ones(6,9)
%         err(6,6)=mean(mean(err));
%         contourf(err);
        err([1:3],1)=1;
        err(1,2)=1;
        err(ii,jj)=1;
        [a1 b1]=min(err);
        [a2 b2]=min(a1);
        po=[b1(b2) b2];
    end
end
