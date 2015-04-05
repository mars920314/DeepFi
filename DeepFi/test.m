clear all
clc

errall=zeros(30,3);
for k=2:2
for fi=1:30
    filename=['.\data\3lat' num2str(k) num2str(fi) '.mat'];
    batchdata=getbatchdata(filename,300,400);
%     batchdata=getonebatchdata(filename,300,400,2);
    dataname=['testbatchdata'];
    save(dataname, 'batchdata');
    err=zeros(9,9);
    tic
    for i=1:9
        for j=1:9
            traindataname=['K:\test\antenna\data3\mnist_weights' num2str(k) num2str(i) num2str(j) '.mat'];
            if(exist(traindataname)==2)
                err(i,j)=errfunc1(dataname,traindataname);
            end
        end
    end
    toc
%     [a1 b1]=max(err);
%     [a2 b2]=max(a1);
%     pocal=[b1(b2) b2];
%     [pocal(1) pocal(2)]=position(pocal(1),pocal(2),'lab');
%     [poori(1) poori(2)]=position(fi,0,'lat');
%     errall(fi,k)=sqrt((pocal(1)-poori(1))^2+(pocal(2)-poori(2))^2);
    
    sumerr=0;
    for i=1:9
        for j=1:9
            if err(i,j)~=1
                sumerr=sumerr+err(i,j);
            else
                err(i,j)=0;
            end
        end
    end
    err=err/sumerr;
    err=err/1;  %
    pocal=zeros(2,1);
    for i=1:9
        for j=1:9
            if err(i,j)~=0
                [xout yout]=position(i,j,'lab');
                pocal(1)=pocal(1)+xout*err(i,j);
                pocal(2)=pocal(2)+yout*err(i,j);
            end
        end
    end
    [poori(1) poori(2)]=position(fi,0,'lat');
    errall(fi,k)=sqrt((pocal(1)-poori(1))^2+(pocal(2)-poori(2))^2);
    fi
    errall(fi,k)
    
end
end
mean(errall)*0.3
median(errall)*0.3
ecdf(errall(:,k)*0.3);