function [ fitness ] = genetic_fitness( population, CE, CT, nClases, algorithm, inGenetic )
    m = size(population, 1);
    fitness = zeros(m, 1);
    for i = 1:m
        k = population(i, 1);
        kf = population(i, 2);
        
        run(algorithm);
        
        fitness(i) = accTr;
    end
end

