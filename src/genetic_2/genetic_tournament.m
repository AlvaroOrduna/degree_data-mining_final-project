function [ parents ] = genetic_tournament( population, fitness, k )
%   PARENTSSELECTIONTOURNAMENT - Selecciona los progenitores por el m�todo
%   del torneo con k contrincantes.

    % Controlar el valor de k
    if k < 1
        error('El valor de k debe ser mayor que cero');
    elseif k > size(population, 1)
        error('El valor de k debe ser menor o igual que el tama�o de la poblaci�n');
    end

    % ParentIndexs contendr� los �ndices de los progenitores
    parentIndexs = zeros(2, 1);

    cP = 1;
    while cP <= 2
        % Seleccionar los k contrincantes
        kOpponents = randperm(size(population, 1), k);
        
        % Calcular el �ndice del mejor de los contrincantes
        [~, kBestIndex] = max(fitness(kOpponents));
        
        % Calcular el �ndice del individuo vencedor
        parentIndexs(cP) = kOpponents(kBestIndex);
        
        % Descartar la repetici�n de progenitores
        if isempty(find(parentIndexs(cP) == parentIndexs(1:cP - 1), 1))
            cP = cP + 1;
        end
    end
        
    % Asignar como progenitor a los ganadores de los torneos
    parents = population(parentIndexs, :);
end

