function [index] = RandomSelect(fitness , population, alphabetFreq)
index = 0;

totalFitness = sum(fitness);
% fitness'
percentage = (fitness ./ totalFitness);
% percentage'
randomNum = rand;
% ranomNum
tempSum = 0;
for i = 1:length(percentage)
    tempSum = tempSum + percentage(i);
    if tempSum  >= randomNum
        index = i;
        break
    end
end


end