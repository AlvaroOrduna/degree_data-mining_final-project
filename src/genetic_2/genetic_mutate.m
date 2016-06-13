function [ chromosome ] = genetic_mutate( chromosome, max, prob )
    for i = 1:length(chromosome)
        if rand < prob
            if i <= 1
                chromosome(i) = randi(max);
            else
                chromosome(i) = ~chromosome(i);
            end
        end
    end
end

