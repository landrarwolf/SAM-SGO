clear;close all;clc;
load('COIL20.mat')
c = 20;
d = 500;

%Accuracy = ones(10,10,11);


for i = 1
    beta = i * 0.1;
    for j = 3
        gamma = j;
        Accuracy(i,:) = LMDFX_SAM_SGO(X,Y,c,d,beta,gamma)
    end
end




load train
sound(y,Fs)
