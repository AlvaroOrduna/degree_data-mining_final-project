% Define parameters
m = 20;
paramMaxValue = 30;
iters = 200;
tournament_k = floor(m/2);
script = '..\knn_fast\main.m';
inGenetic = 1;

% Initialize population
population = [randi(paramMaxValue, [m 2]) (randi(2, [m numAtr]) - 1)];
    
% Calculate population's fitness
fitness = genetic_fitness(population, CE, CT, nClases, script, inGenetic);

% Iterate while fitness gets better
i = 0;
bestFitness = max(fitness);
bestFitnessPrev = 0;
while i < iters || (bestFitness - bestFitnessPrev) > 0.00000001
    fprintf('.');
    newPopulation = zeros(size(population));
    
    for j = 1:2:m
        % Select parents
        parents = genetic_tournament(population, fitness, tournament_k);

        % Crossover parents to create children
        progeny = genetic_crossover(parents);

        % Mutate children
        newPopulation(j, :) =  genetic_mutate(progeny(1, :), paramMaxValue, 0.01);
        newPopulation(j + 1, :) =  genetic_mutate(progeny(2, :), paramMaxValue, 0.01);
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
variableSelection = population(bestChromosomeIndex, 3:end);
CE = CE(:, logical([variableSelection 1]));
CT = CT(:, logical([variableSelection 1]));
run(script);

fprintf('GENETIC (%d): Con k = %d y kf = %d: accTr = %f y accTst = %f\n', i, k, kf, accTr, accTst);
disp(population(bestChromosomeIndex, :))