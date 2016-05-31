function[] = graphXY()

fTrain = '../data/cleveland_tra.dat';
fTest = '../data/cleveland_tst.dat';
[numAtr, nClases, infoAtr, CE, CT, ejClase] = lecturaDatos(fTrain, fTest);
minimum = infoAtr(:, 1)';
maximum = infoAtr(:, 2)';
CE(:, 1:end - 1) = bsxfun(@rdivide, bsxfun(@minus, CE(:, 1:end - 1), minimum), (maximum - minimum));
CT(:, 1:end - 1) = bsxfun(@rdivide, bsxfun(@minus, CT(:, 1:end - 1), minimum), (maximum - minimum));
for xLoc = 1:numAtr
    xTst = CT(:,xLoc)';
    xTr = CT(:,xLoc)';
    % y = CE(:,yLoc)';
    zTr = CT(:,end)';
    zTst = CT(:,end)';
    for i = 1:5
        
    end
    
    for i = 1:5
        choose = CT(:,end) == i;
        choose = CT(choose,xLoc);
        averageValXTst(i) = mean(choose);
        
        choose2 = CE(:,end) == i;
        choose2 = CE(choose2,xLoc);
        averageValXTr(i) = mean(choose2);
        
    end
    colors = ['r' 'y' 'g' 'b' 'm'];
    
    gscatter(zTst,xTst,zTst,colors,[],[]);
    name = strcat('GraphOfAtributeTst',num2str(xLoc));
    title(name);
    xlabel('class number');
    ylabel('value (normalized)');
    
    for i = 1:5
        mu = averageValXTst(i);
        hline = refline([0 mu]);
        hline.Color = colors(i);
    end
    
    savefig(strcat('..\graphs\',name,'.fig'))
    
    gscatter(zTst,xTst,zTst,colors,[],[]);
    name = strcat('GraphOfAtributeTr',num2str(xLoc));
    
    for i = 1:5
        mu = averageValXTr(i);
        hline = refline([0 mu]);
        hline.Color = colors(i);
    end
    savefig(strcat('..\graphs\',name,'.fig'))
    
end
end

