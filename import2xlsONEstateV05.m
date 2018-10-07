%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% self-use for fMRI code                          %%%
%%% by justlive 20171031  v02.20171113              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
%%% load from txt BOLD signal transform format to xls%%%
BOLDSig1=load(uigetfile('///*.txt', '½Ð¿é¤JSubject BOLDSignal before///'));
BOLDSig1=BOLDSig1(:,:);

%%% calculate Pearson Correlation coefficient
[Corr1, CorrP1] = corrcoef(BOLDSig1);
[rowSig1,columSig1]=size(BOLDSig1);
datasize1=[rowSig1,columSig1];
CorrBW1=Corr1>0.75;

%%% use Fisher r-to-z transformation
for j=1:116
   for i=1:columSig1;
    FunctC1=Corr1(:,i);
    eval(['BrainRegion' num2str(i) 'FunctC1= FunctC1;' ]);
    Frz1(j,i)=0.5*log((1+eval(['BrainRegion' num2str(i) 'FunctC1(j,1)']))/(1-eval(['BrainRegion' num2str(i) 'FunctC1(j,1)'])));
   end
end

%%%% add fractal, nonfractal %%%
warning off
fprintf('Processing an fMRI data...\n');

[Hurst_BOLDSig1, NFCON_BOLDSig1, FCON_BOLDSig1] = bfn_mfin_ml(BOLDSig1, ...         
                    'range'     ,[2 100],...
                    'abstol'    ,1e-10,...
                    'maxit'     ,100,...
                    'omegamode' ,'lin',...
                    'verbose'   ,0);
         

%%%xlswrite
xlswrite('subjectdata',BOLDSig1,'BOLDSigBefore');

xlswrite('subjectdata',Corr1,'CorrBefore');
xlswrite('subjectdata',CorrP1,'CorrPBefore');


xlswrite('subjectdata',datasize1,'datasizeBefore');

xlswrite('subjectdata',Frz1,'FisherZBefore');

xlswrite('subjectdata',Hurst_BOLDSig1,'Hurst_BOLDSigBefore');

xlswrite('subjectdata',FCON_BOLDSig1,'FCON_Before');
xlswrite('subjectdata',NFCON_BOLDSig1,'NFCON_Before');



%%% plot
figure,imagesc(Corr1,[0:1]);colormap(jet);colorbar;
print('-djpeg','01subjectFunctC_Before');
figure,imagesc(CorrBW1,[0:1]);colormap(gray);colorbar;
print('-djpeg','01subjectFunctCBW_Before');

figure,imagesc(Frz1);colormap(jet);colorbar;
print('-djpeg','subjectFisherZ_01Before');

%%% plot odd+even
oeCorr = [Corr1(1:2:116,1:2:116) Corr1(1:2:116,2:2:116);Corr1(2:2:116,1:2:116) Corr1(2:2:116,2:2:116)];
figure,imagesc(oeCorr,[0:1]);colormap(jet);colorbar;
print('-djpeg','01subjectFunctC_Before_OddEven');


%%% compare pearson, fractal, nonfractal
fprintf('Creating plots...\n');
figure('position',[100 100 1350 450]);
colormap Jet

subplot(1,3,1); imagesc(NFCON_BOLDSig1,[0 1]);
title('Nonfractal connectivity (fMRI)'  ,'FontSize',10); set(gca,'PlotBoxAspectRatio',[1.2 1 1])
subplot(1,3,2); imagesc(FCON_BOLDSig1,[0 1]);
title('Fractal connectivity (fMRI)'  ,'FontSize',10); set(gca,'PlotBoxAspectRatio',[1.2 1 1])
subplot(1,3,3); imagesc(Corr1,[0 1]);
title('Pearson correlation (fMRI)'      ,'FontSize',10); set(gca,'PlotBoxAspectRatio',[1.2 1 1])

print('-djpeg','FractalCompare_all');

drawnow
set(gcf, 'Name', 'Fractal analysis in fMRI data');

warning on
%%% fractal FC plot %%%
figure,imagesc(NFCON_BOLDSig1,[0:1]);colormap(jet);colorbar;
print('-djpeg','NFCON_Before');


figure,imagesc(FCON_BOLDSig1,[0:1]);colormap(jet);colorbar;
print('-djpeg','FCON_Before');

