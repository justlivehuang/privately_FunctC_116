%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% self-use for fMRI code                          %%%
%%% by justlive 20180918  v01                       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
%%% load from txt BOLD signal transform format to xls%%%
[filename,filepath]=uigetfile('*.xls','Please select xls file to load');
NFraC=xlsread([filepath,filename],'NFCON_Before');
[rowSig1,columSig1]=size(NFraC);

%%% Strength of FunctConnectivity for every nodes %%%

Strength_NFractalC=(sum(NFraC-eye(columSig1)))/(columSig1-1);

%%% transform SFunctC(r) to Z, use Fisher r-to-z transformation
%%% 此為 先算個別ROI的FC強度，再轉換成Z %%%

Strength_Z_NFractalC=0.5*log((1+Strength_NFractalC)./(1-Strength_NFractalC));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% use Fisher r-to-z transformation
Corr11=NFraC-eye(columSig1);
for j=1:116
   for i=1:columSig1
    FunctC1=Corr11(:,i);
    eval(['BrainRegion' num2str(i) 'FunctC1= FunctC1;' ]);
    Z_NFC(j,i)=0.5*log((1+eval(['BrainRegion' num2str(i) 'FunctC1(j,1)']))/(1-eval(['BrainRegion' num2str(i) 'FunctC1(j,1)'])));
   end
end

%%%%% Strength_Z_NFractalC %%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,plot(Strength_Z_NFractalC);
print('-djpeg','Strength_Z_NFractalC');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlswrite('subjectdata',Z_NFC,'Z_NFC');
xlswrite('subjectdata',Strength_Z_NFractalC,'Strength_Z_NFractalC');

%%%% histogram/imagesc of STRENGTH of FunctConnectivity %%%%
figure,histogram(Strength_NFractalC);
print('-djpeg','Strength_NFractalC_histogram');

figure,imagesc(Strength_NFractalC,[0 1]);colormap(jet);colorbar;
print('-djpeg','Strength_NFractalC_imagesc');