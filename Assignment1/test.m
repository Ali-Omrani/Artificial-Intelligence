clear
clc

%% init
alphabet = 'A' : 'Z';
alphabet = alphabet';
occuranceFreq = CharacterOccurance('EncryptedText');
res{1} = alphabet;
res{2} = occuranceFreq;
alphabetFreq = AlphabetFrequency('Freq.txt');

%% generate first population
firstPopulationSize = 50;
P = cell(2, firstPopulationSize);
for i = 1:firstPopulationSize
    permutation = randperm(26);
    newAlphabet = alphabet(permutation);
    newFreq = occuranceFreq(permutation);
    P{1, i} = newAlphabet;
    P{2, i} = newFreq;
end
% celldisp(P)
%%
fileName = 'EncryptedText';
mutationProbability = 0.2;
crossOverProbability = 0.8;
iteration = 500;
maxFit = 0;

while 1
    newPopulation = cell(2, firstPopulationSize);
    fitness = MultiFitnessFunction(fileName , P, alphabetFreq);
%     fitness'
    max(fitness)
    maxFit = max(maxFit ,max(fitness))
    if max(fitness) > 2400 
        break
    end
    for j= 1:firstPopulationSize
        index1 = RandomSelect(fitness, P, alphabetFreq);
        index2 = RandomSelect(fitness, P, alphabetFreq);
        if rand <= crossOverProbability
            [newAlphabet, newFreq] = CrossOver(P{:,index1}, P{:,index2});
        else
            if rand <= 0.5
                newAlphabet = P{1,index2};
                newFreq = P{2,index2};
            else
                newAlphabet = P{1,index1};
                newFreq = P{2,index1};
            end
        end
        
        if rand <= mutationProbability
            [newAlphabet, newFreq] = mutation(newAlphabet, newFreq);
        end
        newPopulation{1,j} = newAlphabet;
        newPopulation{2,j} = newFreq;
    end
    P = newPopulation;
end

fitness = MultiFitnessFunction(fileName, P, alphabetFreq);
% maxFitness = max(fitness)
maxFit






