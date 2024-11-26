function [sigma_] = newton(p)
X=0;%迭代初值
t=0;%迭代次数计算
while t <= 100       %迭代次数
    x0=X-g(X,p)/g_(X,p);     %牛顿迭代格式
    if abs(x0-X)>0.000001   %收敛判断
        X=x0;
    else
        break
    end
    t=t+1;
end

sigma_ = X ;

%fprintf('\n%s%.4f\t%s%d','X=',sigma_i,'i=',i) %输出结果
end

%[sigma_] = newton([6,5,4,3,2,1,0,-1,-2,-3])

%[sigma_] = newton((p(1,:)))