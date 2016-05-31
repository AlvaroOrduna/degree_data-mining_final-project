% Define parameters
m = 20;
paramMaxValue = 10;
iters = 50;
script = '..\knn_fast\main.m';
inGenetic = 1;

% Initialize population
population = randi(paramMaxValue, [m 2]);
    
% Calculate population's fitness
fitness = genetic_fitness(population, CE, CT, nClases, script, inGenetic);

% Iterate while fitness gets better
i = 0;
bestFitness = max(fitness);
bestFitnessPrev = 0;
while i < iters %&& (bestFitness - bestFitnessPrev) > 0.00000001
    fprintf('.');
    newPopulation = zeros(size(population));
    
    for j = 1:2:m
        % Select parents
        parents = genetic_tournament(population, fitness, 12);

        % Crossover parents to create children
        child1 = parents(1,:);
        child2 = parents(2,:);
        child1(2) = parents(2,2);
        child2(2) = parents(1,2);

        % Mutate children
        newPopulation(j, :) =  genetic_mutate(child1, paramMaxValue, 0.01);
        newPopulation(j + 1, :) =  genetic_mutate(child2, paramMaxValue, 0.01);
    end
    
    % Substitute old population
    population = newPopulation;
    
    % Calculate new population's fitness
    fitness = genetic_fitness(population, CE, CT, nClases, script, inGenetic);
    
    i = i + 1;
    
    bestFitnessPrev = bestFitness;
    bestFitness = max(fitness);
end
    
% Execute knn_fuzzy with optimal paramaters
inGenetic = 0;
[~, bestChromosomeIndex] = max(fitness);
k = population(bestChromosomeIndex, 1);
kf = population(bestChromosomeIndex, 2);
run(script);

fprintf('GENETIC (%d): Con k = %d y kf = %d: accTr = %f y accTst = %f\n', i, k, kf, accTr, accTst);