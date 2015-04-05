% Code provided by Ruslan Salakhutdinov 
%
% Permission is granted for anyone to copy, use, modify, or distribute this
% program and accompanying programs and documents for any purpose, provided
% this copyright notice is retained and prominently displayed, along with
% a note saying that the original programs are available from our
% web page.
% The programs and documents are distributed without any warranty, express or
% implied.  As the programs were written for research purposes only, they have
% not been tested to the degree that would be advisable in any important
% application.  All use of these programs is entirely at the user's own risk.

How to make it work:

   1. Create a separate directory and download all these files into the same directory
   2. Download from http://yann.lecun.com/exdb/mnist the following 4 files:
          * train-images-idx3-ubyte.gz train-labels-idx1-ubyte.gz
          * t10k-images-idx3-ubyte.gz t10k-labels-idx1-ubyte.gz 
   3. Unzip these 4 files by executing:
          * gunzip train-images-idx3-ubyte.gz
          * gunzip train-labels-idx1-ubyte.gz
          * gunzip t10k-images-idx3-ubyte.gz
          * gunzip t10k-labels-idx1-ubyte.gz 
      If unzipping with WinZip, make sure the file names have not been
      changed by Winzip. 
   4. Download the following 15 files:
          * demo_toy.m Main file for training and evaluating a toy RBM model. 
          * demo_rbm.m Main file for evaluating an RBM model (mnistvh_CD25.mat).
          * converter.m Converts raw MNIST digits into matlab format
          * rbm.m Training RBM with binary hidden and visible units
          * calculate_true_partition.m Calculates the true log-partition 
            function of the toy model.
	  * RBM_AIS.m Estimates partition function using AIS.
          * base_rate.m Estimates biases of the base-rate model by maximum likelihood.
          * logsum.m Helper function used by RBM_AIS.m.
          * logdiff.m Helper function used by RBM_AIS.m.
          * free_energy.m Helper function used by RBM_AIS.m  
          * makebatches.m Creates minibatches for RBM training
          * mnistdisp.m Displays progress during AIS run.
          * mnistvh_CD25.mat Parameters of the carefully trained RBM model using CD25. 
  	  * calculate_logprob.m Calculates log-probability of data by summing out hidden units.       
          * README.txt 
   6. For the toy experiment, run demo_toy in matlab.
   7. For running an AIS on the big RBM model, run demo_rbm in matlab.
   8. Make sure you have enough space to store the entire MNIST dataset on your disk. 
      You can also set various parameters in the code, such as maximum number of epochs, 
      learning rates, network architecture, etc. 

