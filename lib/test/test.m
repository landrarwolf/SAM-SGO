load('COIL20.mat')%1440����1024ά��
%load('id.mat')%1024
%%
%��ĳ�㷨 ѡ��ǰ**�������� h = 200
%��[id];
[~,t]=sort(id);
a = t(1:90);
b = t(1024-90:1024);

X1 = X(:,a);
X2 = X(:,b);
X3 = X;
%%
[idx1] = kmeans(X1, 20);                  %kmeans
[idx2] = kmeans(X2, 20); 
[idx3] = kmeans(X3, 20); 
%idx1=kmeans(X1,20,'Replicates',5);%׼ȷ�ʸߵ�
%idx2=kmeans(X2,20,'emptyaction','singleton','Replicates',5);%׼ȷ�ʸߵ�
[FMeasure1,Accuracy1]= Fmeasure(Y',idx1')
[FMeasure2,Accuracy2]= Fmeasure(Y',idx2')
[FMeasure3,Accuracy3]= Fmeasure(Y',idx3')