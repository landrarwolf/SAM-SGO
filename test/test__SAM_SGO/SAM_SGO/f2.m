function [A,lambda] = f2(k,X)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global num

distX = L2_distance_1(X,X);%�������
[distX1, idx] = sort(distX,2);%�����С��������,idx�Ƕ�Ӧ����λ�ã�����idx��һ�е�һ��Ϊ2��˵���ڶ�������С
A = zeros(num); rr = zeros(num,1);%��ʼ�����ƾ���A��rr

for i = 1:num
    di = distX1(i,2:k+2);
    rr(i) = 0.5*(k*di(k+1)-sum(di(1:k)));
    id = idx(i,2:k+2);
    A(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);
end
r = mean(rr);   %��alpha��ȷ���Ͳ�����
lambda = r;     %ȷ������lambda������Tr(FT Ls F)��ϵ����������Ӧ����

end

