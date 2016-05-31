function [ parents ] = genetic_roulette( population, fitness )
%   PARENTSSELECTIONROULETTE - Selecciona los progenitores por el método de
%   la ruleta, otorgando a cada individuo de la población una probabilidad 
%   de ser seleccionado proporcional a la idoneidad de su fitness. Así, es
%   más probable seleccionar a los individuos con mejor fitness.

    % ParentIndexs contendrá los índices de los progenitores
    parentIndexs = zeros(2, 1);

    %% Calcular el tamaño de los sectores de la ruleta.
    % Como el mejor fitness es el más cercano a cero, debemos trabajar con
    % la inversa del fitness.
    fitnessProb = fitness ./ sum(fitness);
    rouletteSectors = cumsum(fitnessProb);
            
    %% Lanzar la ruleta para elegir los índices de los progenitores
    cP = 1;
    while cP <= 2
        % Lanzar la ruleta y seleccionar el resultado como progenitor
        parentIndexs(cP) = find(rouletteSectors >= rand, 1);
        
        % Descartar la repetición de progenitores
        if isempty(find(parentIndexs(cP) == parentIndexs(1:cP - 1), 1))
            cP = cP + 1;
        end
    end

    %% Obtener los progenitores elegidos
    parents = population(parentIndexs, :);
end

