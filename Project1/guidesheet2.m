%LDA/QDA classifiers
featuresWhole=trainData;
featuresSubset=trainData(:,1:10:end);
labels=trainLabels;

%using subset of features
classifierLin=fitcdiscr(featuresSubset,labels,'DiscrimType','linear');
classifierLinUnif=fitcdiscr(featuresSubset,labels,'DiscrimType','linear','prior','uniform');
classifierDiagLin=fitcdiscr(featuresSubset,labels,'DiscrimType','diaglinear','prior','uniform');
%classifierQuad=fitcdiscr(featuresSubset,labels,'DiscrimType','quadratic');
%covariance matrix SINGULAR 
classifierDiagQuad=fitcdiscr(featuresSubset,labels,'DiscrimType','diagquadratic','prior','uniform')

yhatLin=predict(classifierLin,featuresSubset);
yhatLinUnif=predict(classifierLinUnif,featuresSubset);
yhatDiagLin=predict(classifierDiagLin,featuresSubset);
%yhatQuad=predict(classifierQuad,featuresSubset);
yhatDiagQuad=predict(classifierDiagQuad,featuresSubset);

%LIN
correctCounterLin=0;
correctCounterLinUnif=0;
correctCounterDiagLin=0;
%correctCounterQuad=0;
correctCounterDiagQuad=0;

for i=1:597
    if(yhatLin(i,1)==trainLabels(i,1))
        correctCounterLin=correctCounterLin+1;
    end
    if(yhatLinUnif(i,1)==trainLabels(i,1))
        correctCounterLinUnif=correctCounterLinUnif+1;
    end
     if(yhatDiagLin(i,1)==trainLabels(i,1))
        correctCounterDiagLin=correctCounterDiagLin+1;
     end
     %if(yhatQuad(i,1)==trainLabels(i,1))
      %  correctCounterQuad=correctCounterQuad+1;
     %end
     if(yhatDiagQuad(i,1)==trainLabels(i,1))
        correctCounterDiagQuad=correctCounterDiagQuad+1;
    end
end

classificationAccuracyLin=correctCounterLin/597;
classificationErrorLin=1-classificationAccuracyLin;

classificationAccuracyLinUnif=correctCounterLinUnif/597;
classificationErrorLinUnif=1-classificationAccuracyLinUnif;

classificationAccuracyDiagLin=correctCounterDiagLin/597;
classificationErrorDiagLin=1-classificationAccuracyDiagLin;

%classificationAccuracyQuad=correctCounterQuad/597;
%classificationErrorQuad=1-classificationAccuracyQuad;

classificationAccuracyDiagQuad=correctCounterDiagQuad/597;
classificationErrorDiagQuad=1-classificationAccuracyDiagQuad;

%error typing
corrError=0;
errError=0;
for i=1:597
    if(yhatLin(i)~=trainLabels(i,1) && trainLabels(i,1)==0)
        corrError=corrError+1;
    else if (yhatLin(i)~=trainLabels(i,1) && trainLabels(i,1)==1)
            errError=errError+1;
        end
    end
end
%classError
numberErr=nnz(trainLabels);
numberCorr=597-numberErr;
classError=0.5*(errError/numberErr)+0.5*(corrError/numberCorr);


%error typing
corrError=0;
errError=0;
for i=1:597
    if(yhatLinUnif(i)~=trainLabels(i,1) && trainLabels(i,1)==0)
        corrError=corrError+1;
    else if (yhatLinUnif(i)~=trainLabels(i,1) && trainLabels(i,1)==1)
            errError=errError+1;
        end
    end
end
%classError
numberErr=nnz(trainLabels);
numberCorr=597-numberErr;
classErrorUnif=0.5*(errError/numberErr)+0.5*(corrError/numberCorr);


