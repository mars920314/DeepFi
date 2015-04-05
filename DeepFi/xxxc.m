function c=xxxc(a,b)
n=length(a);
c1=0;
c2=0;
c3=0;
for i=1:n
    c1=c1+a(i)*b(i);
    c2=c2+a(i)^2;
    c3=c3+b(i)^2;
end
c=c1/(sqrt(c2)*sqrt(c3));