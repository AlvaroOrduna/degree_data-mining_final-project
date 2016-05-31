function [ progeny ] = genetic_crossover( parents )

    progeny = zeros(size(parents));
    
    % Crossover two first gens
    progeny(1, 1:2) = round(mean(parents(:, 1:2)));
    progeny(2, 1:2) = round(mean(parents(:, 1:2)));
    
    % Binary crossover (HUX)
    progeny(1, 3:end) = parents(1, 3:end);
    progeny(2, 3:end) = parents(2, 3:end);
    
    different = [zeros(1, 2) parents(1, 3:end) ~= parents(2, 3:end)];
    differentIndexes = find(different);
    
    changeIndexes1 = randsample(differentIndexes, floor(length(differentIndexes)/2));
    changeIndexes2 = randsample(differentIndexes, floor(length(differentIndexes)/2));
    
    progeny(1, changeIndexes1) = ~progeny(1, changeIndexes1);
    progeny(2, changeIndexes2) = ~progeny(2, changeIndexes2);
end

