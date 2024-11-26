clear;clc;
load('matlab.mat')



p(:,:)=BlogCatalog(:,:);
plot(p,'DisplayName','p')
bar3(p)
