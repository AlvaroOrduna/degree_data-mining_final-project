function[] = graphXY()
%%Read and normalize data
fTrain = '../data/cleveland_tra.dat';
fTest = '../data/cleveland_tst.dat';
[numAtr, nClases, infoAtr, CE, CT, ejClase] = lecturaDatos(fTrain, fTest);
minimum = infoAtr(:, 1)';
maximum = infoAtr(:, 2)';
CE(:, 1:end - 1) = bsxfun(@rdivide, bsxfun(@minus, CE(:, 1:end - 1), minimum), (maximum - minimum));
CT(:, 1:end - 1) = bsxfun(@rdivide, bsxfun(@minus, CT(:, 1:end - 1), minimum), (maximum - minimum));

%%Create a figure for each attribute
for xLoc = 1:numAtr
    xTr = CE(:,xLoc)';
    zTr = CE(:,end)';
 
    xTst = CT(:,xLoc)';
    zTst = CT(:,end)';
    

    
     name = 'Atr';
    colors = ['r' 'y' 'g' 'b' 'm'];
    
    subplot(1,2,1);
    gscatter(zTr,xTr,zTr,colors,[],[]);
    xlabel('class number');
    ylabel('value (normalized)');
    title(strcat(name,'Tr',num2str(xLoc)));
    
    %%Find average of each class
    averageValXTr = zeros(nClases,1);
    for i = 1:nClases
                choose2 = CE(:,end) == i;
        choose2 = CE(choose2,xLoc);
        averageValXTr(i) = mean(choose2);
        
        mu = averageValXTr(i);
        hline = refline([0 mu]);
        hline.Color = colors(i);
    end
    
    
    subplot(1,2,2);

    gscatter(zTst,xTst,zTst,colors,[],[]);
   
    title(strcat(name,'Tst',num2str(xLoc)));
    xlabel('class number');
    ylabel('value (normalized)');
    
    
    
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

