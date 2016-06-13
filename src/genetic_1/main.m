%% GENETIC_1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determina la mejor combinación para el valor de k, selección de variables
% y selección de ejemplos de todas las clases
%
% La representación de cromosoma es la siguiente:
%   cromosoma(1) = valor de k
%   cromosoma(2:numAtr + 1) = selección de variables
%   cromosoma(numAtr + 2:end) = selección de ejemplos de todas las clases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define parameters
m = 20;
kMaxValue = 30;
numExamples = size(CE, 1);
iters = 500;
tournament_k = floor(m/2);
script = '..\knn_fast\main.m';
inGenetic = 1;
delta = 1e-100;

% Initialize population
population = [randi(kMaxValue, [m 1]) (randi(2, [m numAtr + numExamples]) - 1)];
    
% Calculate population's fitness
fitness = genetic_fitness(population, CE, CT, numAtr, nClases, script, inGenetic);

% Iterate while fitness gets better
i = 0;
bestFitness = max(fitness);
bestFitnessPrev = 0;
while i < iters %&& (bestFitness - bestFitnessPrev) > delta
    if rem(i, 50) == 0
        fprintf('\n%4d ', i);
    end
    fprintf('.');
    newPopulation = zeros(size(population));
    
    for j = 1:2:m
        % Select parents
        parents = genetic_tournament(population, fitness, tournament_k);

        % Crossover parents to create children
        progeny = genetic_crossover(parents);

        % Mutate children
        newPopulation(j, :) =  genetic_mutate(progeny(1, :), kMaxValue, 0.01);
        newPopulation(j + 1, :) =  genetic_mutate(progeny(2, :), kMaxValue, 0.01);
    end
    
    % Substitute old population
    population = newPopulation;
    
    % Calculate new population's fitness
    fitness = genetic_fitness(population, CE, CT, numAtr, nClases, script, inGenetic);
    
    i = i + 1;
    
    bestFitnessPrev = bestFitness;
    bestFitness = max(fitness);
end

% Execute knn_fuzzy with optimal paramaters
inGenetic = 0;
[~, bestChromosomeIndex] = max(fitness);
k = population(bestChromosomeIndex, 1);
variableSelection = population(bestChromosomeIndex, 2:numAtr + 1);
dataSelection = logical(population(bestChromosomeIndex, numAtr + 2:end))';
CE = CE(dataSelection, logical([variableSelection 1]));
CT = CT(:, logical([variableSelection 1]));
run(script);

fprintf('\nGENETIC (%d): Con k = %d: accTr = %f y accTst = %f\n', i, k, accTr, accTst);
% disp(population(bestChromosomeIndex, :))