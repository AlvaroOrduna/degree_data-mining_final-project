function [ chormosome ] = genetic_mutate( chormosome, max, prob )
    for i = 1:length(chormosome)
        if rand < prob
            chormosome(i) = randi(max);
        end
    end
end

