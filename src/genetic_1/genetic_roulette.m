function [ parents ] = genetic_roulette( population, fitness )
%   PARENTSSELECTIONROULETTE - Selecciona los progenitores por el m�todo de
%   la ruleta, otorgando a cada individuo de la poblaci�n una probabilidad 
%   de ser seleccionado proporcional a la idoneidad de su fitness. As�, es
%   m�s probable seleccionar a los individuos con mejor fitness.

    % ParentIndexs contendr� los �ndices de los progenitores
    parentIndexs = zeros(2, 1);

    %% Calcular el tama�o de los sectores de la ruleta.
    % Como el mejor fitness es el m�s cercano a cero, debemos trabajar con
    % la inversa del fitness.
    fitnessProb = fitness ./ sum(fitness);
    rouletteSectors = cumsum(fitnessProb);
            
    %% Lanzar la ruleta para elegir los �ndices de los progenitores
    cP = 1;
    while cP <= 2
        % Lanzar la ruleta y seleccionar el resultado como progenitor
        parentIndexs(cP) = find(rouletteSectors >= rand, 1);
        
        % Descartar la repetici�n de progenitores
        if isempty(find(parentIndexs(cP) == parentIndexs(1:cP - 1), 1))
            cP = cP + 1;
        end
    end

    %% Obtener los progenitores elegidos
    parents = population(parentIndexs, :);
end

