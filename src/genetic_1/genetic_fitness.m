function [ fitness ] = genetic_fitness( population, CE, CT, numAtr, nClases, algorithm, inGenetic )
    m = size(population, 1);
    fitness = zeros(m, 1);
    
    CEorg = CE;
    CTorg = CT;
    
    for i = 1:m
        k = population(i, 1);
        variableSelection = population(i, 2:numAtr + 1);
        dataSelection = logical(population(i, numAtr + 2:end))';
        CE = CEorg(dataSelection, logical([variableSelection 1]));
        CT = CTorg(:, logical([variableSelection 1]));
        
        run(algorithm);
        
        fitness(i) = accTr;
    end
    
    CE = CEorg;
    CT = CTorg;
end

