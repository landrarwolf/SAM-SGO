function [sigma_] = newton(p)
X=0;%������ֵ
t=0;%������������
while t <= 100       %��������
    x0=X-g(X,p)/g_(X,p);     %ţ�ٵ�����ʽ
    if abs(x0-X)>0.000001   %�����ж�
        X=x0;
    else
        break
    end
    t=t+1;
end

sigma_ = X ;

%fprintf('\n%s%.4f\t%s%d','X=',sigma_i,'i=',i) %������
end

%[sigma_] = newton([6,5,4,3,2,1,0,-1,-2,-3])

%[sigma_] = newton((p(1,:)))