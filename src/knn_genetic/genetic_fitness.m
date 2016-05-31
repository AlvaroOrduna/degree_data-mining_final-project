function [ fitness ] = genetic_fitness( population, CE, CT, nClases, algorithm, inGenetic )
    m = size(population, 1);
    fitness = zeros(m, 1);
    
    CEorg = CE;
    CTorg = CT;
    
    for i = 1:m
        k = population(i, 1);
        kf = population(i, 2);
        variableSelection = population(i, 3:end);
        CE = CEorg(:, logical([variableSelection 1]));
        CT = CTorg(:, logical([variableSelection 1]));
        
        run(algorithm);
        
        fitness(i) = accTr;
    end
    
    CE = CEorg;
    CT = CTorg;
end

