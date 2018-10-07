%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% self-use for fMRI code                          %%%
%%% by justlive v01.20180104                        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
%%% load from xls%%%
[filename,filepath]=uigetfile('*.xls','Please select xls file to load');
FZ=xlsread([filepath,filename],'FisherZBefore');

%%% calculate
List01=[];

 for i=0:0.0001:0.95

     FZBW01=FZ>i;
     AmountFZBW01=0.5*((length(find(FZBW01==1)))-116);
     Density01=AmountFZBW01/6670;
     List01=[List01;i Density01];
    
 end


[r1 r2]=find(List01(:,2)<=0.5);
k1=r1(1)+1;
LEFTband=[List01(k1,1) List01(k1,2)];

[r3 r4]=find(List01(:,2)<=0.37);
k2=r3(1)-1;
RIGHTband=[List01(k2,1) List01(k2,2)];

%%% plot
figure,plot(List01(k1:k2,1),List01(k1:k2,2));
print('-djpeg','density(Y)_threshold(X)');

FZ_R=FZ>List01(k2,1);
FZ_Rde=FZ_R-eye(116);
figure,imagesc(FZ_Rde);colormap(gray);
print('-djpeg','density_037_FC');

FZ_L=FZ>List01(k1,1);
FZ_Lde=FZ_L-eye(116);
figure,imagesc(FZ_Lde);colormap(gray);
print('-djpeg','density_050_FC');

xlswrite('ComplexNetDATA',FZ_Lde,'Density050');
xlswrite('ComplexNetDATA',FZ_Rde,'Density037');
xlswrite('ComplexNetDATA',LEFTband,'Threshold050');
xlswrite('ComplexNetDATA',RIGHTband,'Threshold037');







