clear;close all;clc;
load('COIL20.mat')
%X = X/255;
c = 20;
d = 200;

[Accuracy(1,:),FMeasure(1,:)] = main_1LapScore(X,Y,c,d);
[Accuracy(2,:),FMeasure(2,:)] = main_2MCFS(X,Y,c,d);
[Accuracy(3,:),FMeasure(3,:)] = main_3cfs(X,Y,c,d);
%%
d = 900;
[Accuracy(4,:),FMeasure(4,:)] = main_4DGUFS(X,Y,c,d);
%%
d = 500;
gamma = 0.3;
[Accuracy(5,:),FMeasure(5,:)] = main_5SOGFS(X,Y,c,d,gamma);
%%
d = 500;
beta = 0.6;
gamma = 0.3;
[Accuracy(6,:),FMeasure(6,:)] = main_6SAM_SGO(X,Y,c,d,beta,gamma);
%%
[Accuracy(7,:),FMeasure(7,:)] = main_0Baseline(X,Y,c,d);
%%
legend
%%
load train
sound(y,Fs)

