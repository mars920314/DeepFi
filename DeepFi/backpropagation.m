maxepoch=5;
fprintf(1,'\nFine-tuning deep autoencoder by minimizing cross entropy error. \n');

load batchdata
load mnistvh
load mnisthp
load mnisthp2
load mnistpo 

[numcases numdims numbatches]=size(batchdata);
w1=[vishid; hidrecbiases];
w2=[hidpen; penrecbiases];
w3=[hidpen2; penrecbiases2];
w4=[hidtop; toprecbiases];
w5=[hidtop'; topgenbiases]; 
w6=[hidpen2'; hidgenbiases2]; 
w7=[hidpen'; hidgenbiases]; 
w8=[vishid'; visbiases];
l1=size(w1,1)-1;
l2=size(w2,1)-1;
l3=size(w3,1)-1;
l4=size(w4,1)-1;
l5=size(w5,1)-1;
l6=size(w6,1)-1;
l7=size(w7,1)-1;
l8=size(w8,1)-1;
l9=l1; 

for epoch = 1:maxepoch
    tt=0;
    for batch = 1:numbatches/10
        fprintf(1,'epoch %d batch %d\r',epoch,batch);
        tt=tt+1; 
        data=[];
        for kk=1:10
            data=[data 
                batchdata(:,:,(tt-1)*10+kk)]; 
        end
        max_iter=3;
        VV = [w1(:)' w2(:)' w3(:)' w4(:)' w5(:)' w6(:)' w7(:)' w8(:)']';
        Dim = [l1; l2; l3; l4; l5; l6; l7; l8; l9];

        [X, fX] = minimize(VV,'CG_MNIST',max_iter,Dim,data);

        w1 = reshape(X(1:(l1+1)*l2),l1+1,l2);
        xxx = (l1+1)*l2;
        w2 = reshape(X(xxx+1:xxx+(l2+1)*l3),l2+1,l3);
        xxx = xxx+(l2+1)*l3;
        w3 = reshape(X(xxx+1:xxx+(l3+1)*l4),l3+1,l4);
        xxx = xxx+(l3+1)*l4;
        w4 = reshape(X(xxx+1:xxx+(l4+1)*l5),l4+1,l5);
        xxx = xxx+(l4+1)*l5;
        w5 = reshape(X(xxx+1:xxx+(l5+1)*l6),l5+1,l6);
        xxx = xxx+(l5+1)*l6;
        w6 = reshape(X(xxx+1:xxx+(l6+1)*l7),l6+1,l7);
        xxx = xxx+(l6+1)*l7;
        w7 = reshape(X(xxx+1:xxx+(l7+1)*l8),l7+1,l8);
        xxx = xxx+(l7+1)*l8;
        w8 = reshape(X(xxx+1:xxx+(l8+1)*l9),l8+1,l9);
    end
    savepath=['.\data\mnist_weights' num2str(j) num2str(i)];
    save(savepath, 'w1', 'w2', 'w3', 'w4', 'w5', 'w6', 'w7', 'w8', 'vishid', 'hidrecbiases', 'visbiases', 'hidpen', 'penrecbiases', 'hidgenbiases', 'hidpen2', 'penrecbiases2', 'hidgenbiases2', 'hidtop', 'toprecbiases', 'topgenbiases');
end
%     