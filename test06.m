%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% self-use for fMRI code                          %%%
%%% by justlive 20180516  v02.180516                %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
%%% load from txt BOLD signal transform format to xls%%%
BOLDSig1=load(uigetfile('///*.txt', '請輸入Subject BOLDSignal before///'));
BOLDSig1=BOLDSig1(:,:);

%%% calculate Pearson Correlation coefficient
[Corr1, CorrP1] = corrcoef(BOLDSig1);
[rowSig1,columSig1]=size(BOLDSig1);
datasize1=[rowSig1,columSig1];

CorrBW1=Corr1>0.75;

%%% Strength of FunctConnectivity for every nodes %%%

SFunctC=(sum(Corr1-eye(columSig1)))/(columSig1-1);    %%% 20180516 add 

%%% transform SFunctC(r) to Z, use Fisher r-to-z transformation
%%% 此為 先算個別ROI的FC強度，再轉換成Z %%%

SFunctCZ=0.5*log((1+SFunctC)./(1-SFunctC));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% use Fisher r-to-z transformation
Corr11=Corr1-eye(columSig1);
for j=1:116
   for i=1:columSig1
    FunctC1=Corr11(:,i);
    eval(['BrainRegion' num2str(i) 'FunctC1= FunctC1;' ]);
    Frz1(j,i)=0.5*log((1+eval(['BrainRegion' num2str(i) 'FunctC1(j,1)']))/(1-eval(['BrainRegion' num2str(i) 'FunctC1(j,1)'])));
   end
end

%%%%% test test test %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 此為從原始FC Matrix，先轉換成Z，再求ROI的FC強度
SFunctCZ_2=(sum(Frz1-eye(columSig1)))/(columSig1-1);

%%% plot SFunctCZ & SFunctCZ_2
figure,plot(SFunctCZ);hold on;plot(SFunctCZ_2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlswrite('subjectdata',SFunctC,'SFunctC');
xlswrite('subjectdata',SFunctCZ,'SFunctCZ');


%%%% histogram/imagesc of STRENGTH of FunctConnectivity %%%%
figure,histogram(SFunctC);
print('-djpeg','StrengthFC_histogram');

figure,imagesc(SFunctC,[0 1]);colormap(jet);colorbar;
print('-djpeg','StrengthFC_imagesc');