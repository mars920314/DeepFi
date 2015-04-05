% Version 1.000
%
% Code provided by Ruslan Salakhutdinov and Geoff Hinton
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

function [err] = mnistdisp(digits);
% display a group of MNIST images 
col=28;
row=28;

[dd,N] = size(digits);
imdisp=zeros(2*28,ceil(N/2)*28);

for nn=1:N
  ii=rem(nn,2); if(ii==0) ii=2; end
  jj=ceil(nn/2);

  img1 = reshape(digits(:,nn),row,col);
  img2(((ii-1)*row+1):(ii*row),((jj-1)*col+1):(jj*col))=img1';
end

imagesc(img2,[0 1]); colormap gray; axis equal; axis off;
drawnow;
err=0; 

