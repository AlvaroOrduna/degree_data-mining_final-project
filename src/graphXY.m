function[] = graphXY()
%%Read and normalize data
fTrain = '../data/cleveland_tra.dat';
fTest = '../data/cleveland_tst.dat';
[numAtr, nClases, infoAtr, CE, CT, ejClase] = lecturaDatos(fTrain, fTest);
minimum = infoAtr(:, 1)';
maximum = infoAtr(:, 2)';
CENorm = CE;
CTNorm = CT;
CENorm(:, 1:end - 1) = bsxfun(@rdivide, bsxfun(@minus, CE(:, 1:end - 1), minimum), (maximum - minimum));
CTNorm(:, 1:end - 1) = bsxfun(@rdivide, bsxfun(@minus, CT(:, 1:end - 1), minimum), (maximum - minimum));
%%Graph each atribute
for xLoc = 1:numAtr
    
    
    name = 'Atr';
    colors = ['r' 'y' 'g' 'b' 'm'];
    normAxis = [1 5 0 1];
    rawAxis = [1 5 min([ min(min(CE(:,xLoc)))...
        min(min(CE(:,xLoc)))]) max([ max(max(CE(:,xLoc)))...
        max(max(CE(:,xLoc)))])];
    
    %%Graph normalized train data
    xTrNorm = CENorm(:,xLoc)';
    zTrNorm = CENorm(:,end)';
    subplot(1,4,1);
    
    
    
    gscatter(zTrNorm,xTrNorm,zTrNorm,colors,[],[]);
    
    title(strcat(name,'TrNorm',num2str(xLoc)));
    xlabel('class number');
    ylabel('value (normalized)');
    axis(normAxis);
    
    
    
    averageValXTr = zeros(nClases,1);
    for i = 1:nClases
        currAtr = CENorm(:,end) == i;
        classVals = CENorm(currAtr,xLoc);
        averageValXTr(i) = mean(classVals);
        
        mu = averageValXTr(i);
        hline = refline([0 mu]);
        hline.Color = colors(i);
        
    end
    
    
    %%Graph normalized test data
    xTstNorm = CTNorm(:,xLoc)';
    zTstNorm = CTNorm(:,end)';
    subplot(1,4,2);
    
    gscatter(zTstNorm,xTstNorm,zTstNorm,colors,[],[]);
    
    title(strcat(name,'TstNorm',num2str(xLoc)));
    xlabel('class number');
    ylabel('value (normalized)');
    axis(normAxis);
    
    averageValXTst = zeros(nClases,1);
    for i = 1:nClases
        currAtr = CTNorm(:,end) == i;
        classVals = CTNorm(currAtr,xLoc);
        averageValXTst(i) = mean(classVals);
        
        mu = averageValXTst(i);
        hline = refline([0 mu]);
        hline.Color = colors(i);
        
    end
    
    %%Graph raw train data
    
    xTr = CE(:,xLoc)';
    zTr = CE(:,end)';
    subplot(1,4,3);
    gscatter(zTr,xTr,zTr,colors,[],[]);
    xlabel('class number');
    ylabel('value');
    axis(rawAxis);
    title(strcat(name,'Tr',num2str(xLoc)));
    
    averageValXTr = zeros(nClases,1);
    for i = 1:nClases
        choose2 = CE(:,end) == i;
        choose2 = CE(choose2,xLoc);
        averageValXTr(i) = mean(choose2);
        
        mu = averageValXTr(i);
        hline = refline([0 mu]);
        hline.Color = colors(i);
    end
    
    %%Graph raw test data
    xTst = CT(:,xLoc)';
    zTst = CT(:,end)';
    subplot(1,4,4);
    
    gscatter(zTst,xTst,zTst,colors,[],[]);
    
    title(strcat(name,'Tst',num2str(xLoc)));
    xlabel('class number');
    ylabel('value');
    axis(rawAxis);
    
    
    
    averageValXTst = zeros(nClases,1);
    for i = 1:nClases
        currAtr = CT(:,end) == i;
        classVals = CT(currAtr,xLoc);
        averageValXTst(i) = mean(classVals);
        
        mu = averageValXTst(i);
        hline = refline([0 mu]);
        hline.Color = colors(i);
        
    end
    
    file_loc = strcat('..\graphs\',name,num2str(xLoc),'.fig');
    savefig(file_loc)
    
end
end

