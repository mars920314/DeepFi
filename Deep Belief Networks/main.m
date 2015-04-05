clear all
close all
clc

% csidata;
% csi2batch;
getbatchdata;
gettestbatchdata;
fprintf(1,'finished');
%%
load batchdatalong;
[numcases numdims numbatches]=size(batchdata);
maxepoch=4; %In the Science paper we use maxepoch=50, but it works just fine. 
numhid=100; numpen=50; numpen2=30; numopen=30;

fprintf(1,'Pretraining Layer 1 with RBM: %d-%d \n',numdims,numhid);
restart=1;
rbm;
hidrecbiases=hidbiases; 
save mnistvh vishid hidrecbiases visbiases;
%%

fprintf(1,'\nPretraining Layer 2 with RBM: %d-%d \n',numhid,numpen);
batchdata=batchposhidprobs;
numhid=numpen;
restart=1;
rbm;
hidpen=vishid; penrecbiases=hidbiases; hidgenbiases=visbiases;
save mnisthp hidpen penrecbiases hidgenbiases;
%%
fprintf(1,'\nPretraining Layer 3 with RBM: %d-%d \n',numpen,numpen2);
batchdata=batchposhidprobs;
numhid=numpen2;
restart=1;
rbm;
hidpen2=vishid; penrecbiases2=hidbiases; hidgenbiases2=visbiases;
save mnisthp2 hidpen2 penrecbiases2 hidgenbiases2;
%%
fprintf(1,'\nPretraining Layer 4 with RBM: %d-%d \n',numpen2,numopen);
batchdata=batchposhidprobs;
numhid=numopen; 
restart=1;
rbmhidlinear;
hidtop=vishid; toprecbiases=hidbiases; topgenbiases=visbiases;
save mnistpo hidtop toprecbiases topgenbiases;
% clear all
fprintf(1,'finished');
%%
load batchdata55;
load testbatchdata55;
% load testbatchdata44;
backprop;
% testerror('testbatchdata13');