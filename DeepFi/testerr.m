%test
clear all
% close all
clc
filename=['.\data\3lat1' num2str(11)];
batchdata=getbatchdata(filename,500,800);
dataname=['testbatchdata'];
save(dataname, 'batchdata');

% err=zeros(1,20);
err=zeros(9,9);
for i=1:9
    for j=1:9
        traindataname=['.\data\mnist_weights' num2str(i) num2str(j) '.mat'];
%         traindataname=['.\data\mnist_weights' num2str(j) '.mat'];
        if(exist(traindataname)==2)
            err(i,j)=errfunc1(dataname,traindataname);
        end
    end
end
err
