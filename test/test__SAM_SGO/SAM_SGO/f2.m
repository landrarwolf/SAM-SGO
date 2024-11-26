function [A,lambda] = f2(k,X)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
global num

distX = L2_distance_1(X,X);%距离矩阵
[distX1, idx] = sort(distX,2);%横向从小到大排列,idx是对应数的位置，比如idx第一行第一列为2，说明第二个数最小
A = zeros(num); rr = zeros(num,1);%初始化相似矩阵A和rr

for i = 1:num
    di = distX1(i,2:k+2);
    rr(i) = 0.5*(k*di(k+1)-sum(di(1:k)));
    id = idx(i,2:k+2);
    A(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);
end
r = mean(rr);   %是alpha，确定就不变了
lambda = r;     %确定就是lambda，后面Tr(FT Ls F)的系数，会自适应调整

end

