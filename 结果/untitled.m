clear;clc;
load('matlab.mat')

% %beta
for i = 1 : 10
    close all
    p(:,:)=Accuracy(i,:,:)
    plot(p,'DisplayName','p')
    bar3(p)
end

%BETA=0.7

%gamma
% for i = 1 : 10
%     close all
%     p(:,:)=Accuracy(:,i,:)
%     plot(p,'DisplayName','p')
%     bar3(p)
% end