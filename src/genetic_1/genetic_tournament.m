function [ parents ] = genetic_tournament( population, fitness, k )
%   PARENTSSELECTIONTOURNAMENT - Selecciona los progenitores por el método
%   del torneo con k contrincantes.

    % Controlar el valor de k
    if k < 1
        error('El valor de k debe ser mayor que cero');
    elseif k > size(population, 1)
        error('El valor de k debe ser menor o igual que el tamaño de la población');
    end

    % ParentIndexs contendrá los índices de los progenitores
    parentIndexs = zeros(2, 1);

    cP = 1;
    while cP <= 2
        % Seleccionar los k contrincantes
        kOpponents = randperm(size(population, 1), k);
        
        % Calcular el índice del mejor de los contrincantes
        [~, kBestIndex] = max(fitness(kOpponents));
        
        % Calcular el índice del individuo vencedor
        parentIndexs(cP) = kOpponents(kBestIndex);
        
        % Descartar la repetición de progenitores
        if isempty(find(parentIndexs(cP) == parentIndexs(1:cP - 1), 1))
            cP = cP + 1;
        end
    end
        
    % Asignar como progenitor a los ganadores de los torneos
    parents = population(parentIndexs, :);
end

